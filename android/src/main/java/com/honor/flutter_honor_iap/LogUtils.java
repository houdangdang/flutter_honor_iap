package com.honor.flutter_honor_iap;

import android.util.Log;

public class LogUtils {
    public static boolean a;

    public LogUtils() {
    }

    public static void v(String var0, String var1) {
        if (a) {
            Log.v("iap_core_" + var0, var1);
        }

    }

    public static void v(String var0) {
        if (a) {
            Log.v(a(), var0);
        }

    }

    public static void v(String var0, Throwable var1) {
        if (a) {
            Log.v(a(), var0, var1);
        }

    }

    public static void d(String var0, String var1) {
        if (a) {
            Log.d("iap_core_" + var0, var1);
        }

    }

    public static void d(String var0) {
        if (a) {
            Log.d(a(), "" + var0);
        }

    }

    public static void d(String var0, Throwable var1) {
        if (a) {
            Log.d(a(), var0, var1);
        }

    }

    public static void i(String var0, String var1) {
        if (a) {
            Log.i("iap_core_" + var0, var1);
        }

    }

    public static void i(String var0) {
        Log.i(a(), var0);
    }

    public static void i(String var0, Throwable var1) {
        Log.i(a(), var0, var1);
    }

    public static void w(String var0, String var1) {
        if (a) {
            Log.w("iap_core_" + var0, var1);
        }

    }

    public static void w(String var0) {
        if (a) {
            Log.w(a(), var0);
        }

    }

    public static void w(String var0, Throwable var1) {
        if (a) {
            Log.w(a(), var0, var1);
        }

    }

    public static void e(String var0, String var1) {
        Log.e("iap_core_" + var0, var1);
    }

    public static void e(String var0) {
        log(a(), var0, (Throwable)null);
    }

    public static void e(String var0, Throwable var1) {
        log(a(), var0, var1);
    }

    public static void e(String var0, String var1, Throwable var2) {
        log(var0, var1, var2);
    }

    public static void log(String var0, String var1, Throwable var2) {
        int var4;
        if (var1.length() > 4000) {
            for(int var3 = 0; var3 < var1.length(); var3 = var4) {
                if ((var4 = var3 + 4000) < var1.length()) {
                    Log.e("iap_core_" + var0, var1.substring(var3, var4), var2);
                } else {
                    Log.e("iap_core_" + var0, var1.substring(var3), var2);
                }
            }
        } else {
            Log.e("iap_core_" + var0, var1, var2);
        }

    }

    public static String a() {
        StackTraceElement[] var0 = (new Throwable()).fillInStackTrace().getStackTrace();
        String var1 = "";

        for(int var2 = 2; var2 < var0.length; ++var2) {
            if (!var0[var2].getClass().equals(LogUtils.class)) {
                String var10000 = var0[var2].getClassName();
                var1 = var10000.substring(var10000.lastIndexOf(46) + 1);
                break;
            }
        }

        return "iap_core_" + var1;
    }

    public static void setLogEnable(boolean var0) {
        a = var0;
    }
}
