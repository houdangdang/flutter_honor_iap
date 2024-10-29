package com.honor.flutter_honor_iap;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import java.util.List;

import androidx.annotation.NonNull;

import com.hihonor.iap.framework.data.ApiException;
import com.hihonor.iap.framework.utils.JsonUtil;
import com.hihonor.iap.framework.utils.logger.LogUtils;
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
import com.hihonor.iap.sdk.bean.ProductOrderIntentWithPriceReq;
import com.hihonor.iap.sdk.bean.ProductType;
import com.hihonor.iap.sdk.bean.PurchaseProductInfo;
import com.hihonor.iap.sdk.bean.PurchaseResultInfo;
import com.hihonor.iap.sdk.tasks.OnFailureListener;
import com.hihonor.iap.sdk.tasks.OnSuccessListener;
import com.hihonor.iap.sdk.tasks.Task;
import com.hihonor.iap.sdk.utils.IapUtil;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener;

public class MethodCallHandlerImpl implements MethodCallHandler, ActivityResultListener {

    private static final String TAG = "MethodCallHandlerImpl";

    private final Activity activity;

    private IapClient mIapClient;

    public MethodCallHandlerImpl(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
        switch (call.method) {
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
                break;
            case "createProductOrderIntentWithPrice":
                break;
            case "cancelSubscriptionProduct":
                break;
            case "consumeProduct":
                break;
            case "getOwnedPurchased":
                break;
            case "getOwnedPurchaseRecord":
                break;
            case "disableLogger":
                break;
            case "enableLogger":
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    @Override
    public boolean onActivityResult(final int requestCode, final int resultCode, final Intent data) {
        // 处理 Activity 的结果，暂时不处理的话可以返回 false
        return false;
    }

    /// 初始化IAP SDK
    private IapClient getIapClient(@NonNull final MethodCall call, @NonNull final Result result) {
        if (mIapClient == null) {
            final String appId = ValueGetter.getString("appId", call);
            final String cpId = ValueGetter.getString("cpId", call);
            mIapClient = Iap.getIapClient(activity, appId, cpId);
        }
        result.success(true);
        return mIapClient;
    }

    //检查当前环境是否可用
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
            result.success(false);
        });
    }

    //获取商品信息
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
        }).addOnFailureListener(e -> {
            LogUtils.e(TAG, String.format("getProductInfo %d %s", e.errorCode, e.message));
        });
    }

}