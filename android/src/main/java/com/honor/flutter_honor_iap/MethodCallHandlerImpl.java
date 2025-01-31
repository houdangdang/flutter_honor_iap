package com.honor.flutter_honor_iap;

import android.app.Activity;
import android.content.Intent;
import android.text.TextUtils;
import android.util.Log;

import java.security.PublicKey;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

import androidx.annotation.NonNull;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import com.hihonor.iap.framework.data.ApiException;
import com.hihonor.iap.framework.utils.JsonUtil;
import com.hihonor.iap.sdk.Iap;
import com.hihonor.iap.sdk.IapClient;
import com.hihonor.iap.sdk.bean.CancelSubscriptionResultReq;
import com.hihonor.iap.sdk.bean.ConsumeReq;
import com.hihonor.iap.sdk.bean.ConsumeResult;
import com.hihonor.iap.sdk.bean.OwnedPurchasesReq;
import com.hihonor.iap.sdk.bean.OwnedPurchasesResult;
import com.hihonor.iap.sdk.bean.ProductInfoReq;
import com.hihonor.iap.sdk.bean.ProductInfoResult;
import com.hihonor.iap.sdk.bean.ProductOrderIntentReq;
import com.hihonor.iap.sdk.bean.ProductOrderIntentResult;
import com.hihonor.iap.sdk.bean.PurchaseProductInfo;
import com.hihonor.iap.sdk.bean.PurchaseResultInfo;
import com.hihonor.iap.sdk.bean.OrderStatusCode;
import com.hihonor.iap.sdk.tasks.OnFailureListener;
import com.hihonor.iap.sdk.tasks.OnSuccessListener;
import com.hihonor.iap.sdk.tasks.Task;
import com.hihonor.iap.sdk.utils.IapUtil;
import com.hihonor.appmarketjointsdk.bean.init.AppParams;
import com.hihonor.appmarketjointsdk.callback.APICallback;
import com.hihonor.appmarketjointsdk.sdk.AMJointSdk;

import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener;

public class MethodCallHandlerImpl implements MethodCallHandler, ActivityResultListener {

    private static final String TAG = "MethodCallHandlerImpl";

    private static final int REQUEST_CODE_PAY = 1001;

    private static boolean mAutoConsume;

    private static String mPublicKey;

    private final Gson mGson;

    private IapClient mIapClient;

    private final Activity mActivity;

    private Result mPurchaseResult;

    public MethodCallHandlerImpl(Activity activity) {
        this.mActivity = activity;
        mGson = new GsonBuilder().create();
    }

    @Override
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
        switch (call.method) {
            case "init":
                init(call, result);
                break;
            case "getIapClient":
                getIapClient(call, result);
                break;
            case "checkEnvReady":
                checkEnvReady(call, result);
                break;
            case "getProductInfo":
                getProductInfo(call, result);
                break;
            case "createProductOrderIntent":
                createProductOrderIntent(call, result);
                break;
            case "createProductOrderIntentWithPrice":
                break;
            case "cancelSubscriptionProduct":
                cancelSubscriptionProduct(call, result);
                break;
            case "consumeProduct":
                consumeProduct(call, result);
                break;
            case "getOwnedPurchased":
                getOwnedPurchased(call, result);
                break;
            case "getOwnedPurchaseRecord":
                getOwnedPurchaseRecord(call, result);
                break;
            case "disableLogger":
                LogUtils.setLogEnable(false);
                result.notImplemented();
                break;
            case "enableLogger":
                LogUtils.setLogEnable(true);
                result.notImplemented();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    @Override
    public boolean onActivityResult(final int requestCode, final int resultCode, final Intent data) {
        if (requestCode == REQUEST_CODE_PAY) {
            // 客户端并不能100%确保支付结果回调
            // 当没收到回调时，可调用getOwnedPurchased、getOwnedPurchaseRecord查询购买记录
            if (resultCode == Activity.RESULT_OK) {
                PurchaseResultInfo purchaseResultInfo = IapUtil.parsePurchaseResultInfoFromIntent(data);
                if (purchaseResultInfo == null) {
                    // 取消支付
                    mPurchaseResult.error(String.valueOf(OrderStatusCode.ORDER_QUICK_PAYMENT_CANCEL), "取消支付", null);
                } else {
                    String purchaseProductInfoStr = purchaseResultInfo.getPurchaseProductInfo();
                    try {
                        PurchaseProductInfo purchaseProductInfo = JsonUtil.parse(purchaseProductInfoStr, PurchaseProductInfo.class);
                        switch (purchaseProductInfo.getPurchaseState()) {
                            case PurchaseProductInfo.PurchaseState.PAID:
                                // 支付成功
                                int productType = purchaseProductInfo.getProductType();
                                if (0 == productType) {
                                    PublicKey publicKey = RSAUtil.getPublicKey(mPublicKey);
                                    boolean verify = RSAUtil.verify(purchaseProductInfoStr, publicKey, purchaseResultInfo.getPurchaseProductInfoSig());
                                    if (verify) {
                                        if (mAutoConsume) {
                                            // 对消耗型商品进行发货，发货成功之后，进行消耗。也就是通知荣耀服务器商品已发货。消耗之后才能重复购买。
                                            autoConsumeProduct(purchaseProductInfo.getPurchaseToken(), mPurchaseResult);
                                        } else {
                                            Map<String, String> purchaseData = new HashMap<>();
                                            purchaseData.put("purchaseToken", purchaseProductInfo.getPurchaseToken());
                                            purchaseData.put("returnCode", "0");
                                            mPurchaseResult.success(mGson.toJson(purchaseData));
                                        }
                                    } else {
                                        mPurchaseResult.error(String.valueOf(OrderStatusCode.ORDER_STATE_AUTH_FAILURE), "公钥验证失败", null);
                                    }
                                } else if (2 == productType) {
                                    String agreementNo = purchaseProductInfo.getSubscription().getAgreementNo();
                                    String iapOrderNo = purchaseProductInfo.getSubscription().getSubIapOrderNo();
                                    String purchaseToken = purchaseProductInfo.getPurchaseToken();
                                    Map<String, String> purchaseData = new HashMap<>();
                                    purchaseData.put("agreementNo", agreementNo);
                                    purchaseData.put("iapOrderNo", iapOrderNo);
                                    purchaseData.put("purchaseToken", purchaseToken);
                                    purchaseData.put("returnCode", "0");
                                    mPurchaseResult.success(mGson.toJson(purchaseData));
                                }
                                break;
                            case PurchaseProductInfo.PurchaseState.UNPAID:
                            case PurchaseProductInfo.PurchaseState.PAID_FAILED:
                            default:
                                // 支付失败
                                LogUtils.d(TAG, "---onActivityResult---支付失败---");
                                mPurchaseResult.error(String.valueOf(OrderStatusCode.ORDER_STATE_FAIL), "支付失败", null);
                        }
                    } catch (Throwable t) {
                        // 支付失败
                        LogUtils.e(TAG, "---onActivityResult---支付失败---" + t.getMessage());
                        mPurchaseResult.error(String.valueOf(OrderStatusCode.ORDER_STATE_FAIL), t.getMessage(), null);
                    }
                }
            } else {
                // 取消支付
                LogUtils.d(TAG, "---onActivityResult---取消支付---");
                mPurchaseResult.error(String.valueOf(OrderStatusCode.ORDER_QUICK_PAYMENT_CANCEL), "取消支付", null);
            }
        }
        return false;
    }

    /// 联运SDK初始化
    private void init(@NonNull final MethodCall call, @NonNull final Result result) {
        if (mActivity != null) {
            final String appId = ValueGetter.getString("appId", call);
            AppParams appParams = new AppParams.Builder().appId(appId).setUserPrivacyState(true).build();
            AMJointSdk.init(appParams, new APICallback() {
                @Override
                public void onSuccess(String message) {
                    LogUtils.d(TAG, " message=" + message);
                    result.success(true);
                }

                @Override
                public void onFailure(int errorCode, String message) {
                    LogUtils.e(TAG, String.valueOf(errorCode) + " message=" + message);
                    result.success(false);
                }
            });
        }
    }

    /// 支付SDK初始化IAP SDK
    private IapClient getIapClient(@NonNull final MethodCall call, @NonNull final Result result) {
        if (mIapClient == null) {
            final String appId = ValueGetter.getString("appId", call);
            final String cpId = ValueGetter.getString("cpId", call);
            this.mPublicKey = ValueGetter.getString("publicKey", call);
            mIapClient = Iap.getIapClient(mActivity, appId, cpId);
        }
        result.success(true);
        return mIapClient;
    }

    /// 检查当前环境是否可用
    private void checkEnvReady(@NonNull final MethodCall call, @NonNull final Result result) {
        if (mIapClient == null) {
            LogUtils.e(TAG, "iap is not installed");
            result.success(false);
            return;
        }

        mIapClient.checkEnvReady().addOnSuccessListener(envReadyResult -> {
            //可用
            result.success(true);
        }).addOnFailureListener(e -> {
            //不可用
            LogUtils.e(TAG, "iap is unavailable code=" + e.errorCode + " message=" + e.message);
            result.error(String.valueOf(e.errorCode), e.message, null);
        });
    }

    /// 获取商品信息
    private void getProductInfo(@NonNull final MethodCall call, @NonNull final Result result) {
        // Arguments from call
        final List<String> productIdList = call.argument("productIds");
        final int priceType = ValueGetter.getInt("priceType", call);

        ProductInfoReq productInfoReq = new ProductInfoReq();
        productInfoReq.setProductType(priceType);
        productInfoReq.setProductIds(productIdList);

        Task<ProductInfoResult> productInfo = mIapClient.getProductInfo(productInfoReq);
        productInfo.addOnSuccessListener(productInfoResult -> {
            LogUtils.d(TAG, "product data is：" + productInfoResult.getProductInfos().toString());
            result.success(mGson.toJson(productInfoResult));
        }).addOnFailureListener(e -> {
            LogUtils.e(TAG, String.format("getProductInfo %d %s", e.errorCode, e.message));
            result.error(String.valueOf(e.errorCode), e.message, null);
        });
    }

    /// 购买PMS商品
    private void createProductOrderIntent(@NonNull final MethodCall call, @NonNull final Result result) {
        // Arguments from call
        final String productId = ValueGetter.getString("productId", call);
        final int priceType = ValueGetter.getInt("priceType", call);
        final int sandboxTest = ValueGetter.getInt("sandboxTest", call);
        final String developerPayload = call.argument("developerPayload") == null ? null : ValueGetter.getString("developerPayload", call);
        mAutoConsume = ValueGetter.getBoolean("autoConsume", call);

        ProductOrderIntentReq productOrderIntentReq = new ProductOrderIntentReq();
        productOrderIntentReq.setProductType(priceType);
        productOrderIntentReq.setProductId(productId);
        productOrderIntentReq.setDeveloperPayload(developerPayload);
        productOrderIntentReq.setNeedSandboxTest(sandboxTest);//传1为沙盒测试

        Task<ProductOrderIntentResult> productOrderIntent = mIapClient.createProductOrderIntent(productOrderIntentReq);
        productOrderIntent.addOnSuccessListener(createProductOrderResp -> {
            Intent intent = createProductOrderResp.getIntent();
            if (intent != null && mActivity != null) {
                mPurchaseResult = result;
                mActivity.startActivityForResult(intent, REQUEST_CODE_PAY);
            }
        }).addOnFailureListener(e -> {
            //e.errorCode 对应 OrderStatusCode的值
            LogUtils.i(TAG, String.format("createProductOrderIntent %d %s", e.errorCode, e.message));
            result.error(String.valueOf(e.errorCode), e.message, null);
        });
    }

    /// 取消订阅
    private void cancelSubscriptionProduct(@NonNull final MethodCall call, @NonNull final Result result) {
        final String agreementNo = ValueGetter.getString("agreementNo", call);
        final String iapOrderNo = ValueGetter.getString("iapOrderNo", call);

        if (TextUtils.isEmpty(agreementNo) && TextUtils.isEmpty(iapOrderNo)) {
            LogUtils.e(TAG, "您暂时没有订阅型商品的订单号和合约号");
            result.error("99890", "您暂时没有订阅型商品的订单号和合约号", null);
            return;
        }
        CancelSubscriptionResultReq cancelSubscriptionResultReq = new CancelSubscriptionResultReq();
        cancelSubscriptionResultReq.setCancelType(2);//固定值，值为2。代表通过SDK提供的cancelSubscriptionProduct调用。
        cancelSubscriptionResultReq.setAgreementNo(agreementNo);//合约号，从获取的已购订阅商品信息中获取
        cancelSubscriptionResultReq.setIapOrderNo(iapOrderNo);//支付成功时生成的订单号
        Task<Object> cancelResultTask = mIapClient.cancelSubscriptionProduct(cancelSubscriptionResultReq);
        cancelResultTask.addOnSuccessListener(o -> {
            result.success(true);
        });
        cancelResultTask.addOnFailureListener(e -> {
            result.error(String.valueOf(e.getErrorCode()), e.getMessage(), null);
        });
    }

    /// 已购买商品进行消耗
    private void consumeProduct(@NonNull final MethodCall call, @NonNull final Result result) {
        final String purchaseToken = ValueGetter.getString("purchaseToken", call);
        autoConsumeProduct(purchaseToken, result);
    }

    /// 查询已购买未消耗的列表(消耗型商品补单需要)、用户已订购商品的购买数据
    private void getOwnedPurchased(@NonNull final MethodCall call, @NonNull final Result result) {
        final int productType = ValueGetter.getInt("productType", call);
        final String[] continueToken = {ValueGetter.getString("continueToken", call)};

        OwnedPurchasesReq ownedPurchasesReq = new OwnedPurchasesReq();
        // 传入上一次查询得到的continueToken，获取新的数据，第一次传空
        ownedPurchasesReq.setProductType(productType);
        ownedPurchasesReq.setContinuationToken(continueToken[0]);
        mIapClient.obtainOwnedPurchases(ownedPurchasesReq).addOnSuccessListener(new OnSuccessListener<OwnedPurchasesResult>() {
            @Override
            public void onSuccess(OwnedPurchasesResult ownedPurchasesResult) {
                // ContinueToken用于获取下一个列表的数据，第一次为空，如果有更多数据ContinueToken有值，为空则没有更多数据
                continueToken[0] = ownedPurchasesResult.getContinueToken();
                // purchaseList 和 sigList 一一对应
                List<String> sigList = ownedPurchasesResult.getSigList();
                List<String> purchaseList = ownedPurchasesResult.getPurchaseList();
                // 签名算法
                String sigAlgorithm = ownedPurchasesResult.getSigAlgorithm();
                // 公钥验签,放在客户端进行签名校验时，7.0.3.000版本之后的SDK，加密算法由"RSA"变更为"RSA_V2"
                if ("RSA_V2".equals(sigAlgorithm)) {
                    try {
                        PublicKey publicKey = RSAUtil.getPublicKey(mPublicKey);
                        LogUtils.d(TAG, " publicKey :" + publicKey);
                        for (int i = 0; i < purchaseList.size(); i++) {
                            String PurchaseProductInfoStr = purchaseList.get(i);
                            boolean verify = RSAUtil.verify(PurchaseProductInfoStr, publicKey, sigList.get(i));
                            Log.d(TAG, " PurchaseProductInfoStr verify " + verify + "  , " + PurchaseProductInfoStr);
                        }
                    } catch (Exception e) {
                        LogUtils.e(TAG, "查询已购买未消耗的列表失败：" + e.getMessage());
                    }
                }
                Log.d(TAG, ownedPurchasesResult.toString());
                result.success(mGson.toJson(ownedPurchasesResult));
            }
        }).addOnFailureListener(new OnFailureListener() {
            @Override
            public void onFailure(ApiException e) {
                // e.errorCode 对应 OrderStatusCode的值
                Log.i(TAG, String.format("createProductOrderIntent %d %s", e.errorCode, e.message));
                result.error(String.valueOf(e.errorCode), e.message, null);
            }
        });
    }

    /// 查看用户历史购买记录
    private void getOwnedPurchaseRecord(@NonNull final MethodCall call, @NonNull final Result result) {
        final int productType = ValueGetter.getInt("productType", call);
        final String[] continueToken = {ValueGetter.getString("continueToken", call)};

        OwnedPurchasesReq ownedPurchasesReq = new OwnedPurchasesReq();
        // 传入上一次查询得到的continueToken，获取新的数据，第一次传空
        ownedPurchasesReq.setContinuationToken(continueToken[0]);
        ownedPurchasesReq.setProductType(productType);
        mIapClient.obtainOwnedPurchaseRecord(ownedPurchasesReq).addOnSuccessListener(new OnSuccessListener<OwnedPurchasesResult>() {
            @Override
            public void onSuccess(OwnedPurchasesResult ownedPurchasesResult) {
                //获取到结果后需要进行签名校验
                //ContinueToken用于获取下一个列表的数据，第一次为空，如果有更多数据ContinueToken有值，为空则没有更多数据
                continueToken[0] = ownedPurchasesResult.getContinueToken();
                Log.d(TAG, ownedPurchasesResult.toString());
                // purchaseList 和 sigList 一一对应
                List<String> sigList = ownedPurchasesResult.getSigList();
                List<String> purchaseList = ownedPurchasesResult.getPurchaseList();
                //签名算法
                String sigAlgorithm = ownedPurchasesResult.getSigAlgorithm();
                //公钥验签,放在客户端进行签名校验时，7.0.3.000版本之后的SDK，加密算法由"RSA"变更为"RSA_V2"
                if ("RSA_V2".equals(sigAlgorithm)) {
                    try {
                        PublicKey publicKey = RSAUtil.getPublicKey(mPublicKey);
                        LogUtils.d(TAG, " publicKey :" + publicKey);
                        for (int i = 0; i < purchaseList.size(); i++) {
                            String PurchaseProductInfoStr = purchaseList.get(i);
                            boolean verify = RSAUtil.verify(PurchaseProductInfoStr, publicKey, sigList.get(i));
                            //verify 为true数据可信，false数据被篡改了，数据不可信
                            Log.d(TAG, " PurchaseProductInfoStr verify " + verify + "  , " + PurchaseProductInfoStr);
                        }
                    } catch (Exception e) {
                        LogUtils.e(TAG, "查看用户历史购买记录失败：" + e.getMessage());
                    }
                }
                result.success(mGson.toJson(ownedPurchasesResult));
            }
        }).addOnFailureListener(new OnFailureListener() {
            @Override
            public void onFailure(ApiException e) {
                //e.errorCode 对应 OrderStatusCode的值
                Log.i(TAG, String.format("createProductOrderIntent %d %s", e.errorCode, e.message));
                result.error(String.valueOf(e.errorCode), e.message, null);
            }
        });
    }

    /**
     * 商品消耗
     *
     * @param purchaseToken
     * @param result
     */
    private void autoConsumeProduct(String purchaseToken, @NonNull final Result result) {
        ConsumeReq comsumeReq = new ConsumeReq();
        // 根据PurchaseToken 进行消耗
        comsumeReq.setPurchaseToken(purchaseToken);
        Task<ConsumeResult> comsumeRespTask = mIapClient.consumeProduct(comsumeReq);
        comsumeRespTask.addOnSuccessListener(comsumeResp -> {
            // 消耗成功
            String consumeData = comsumeResp.getConsumeData();
            Map<String, String> purchaseData = new HashMap<>();
            purchaseData.put("consumeData", consumeData);
            purchaseData.put("returnCode", "0");
            result.success(mGson.toJson(purchaseData));
        }).addOnFailureListener(e -> {
            // 消耗失败
            LogUtils.e(TAG, "消耗失败：" + e.getErrorCode() + ": " + e.getMessage());
            result.error(String.valueOf(e.getErrorCode()), e.getMessage(), null);
        });
    }
}