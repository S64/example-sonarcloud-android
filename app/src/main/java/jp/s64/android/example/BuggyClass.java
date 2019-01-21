package jp.s64.android.example;

import android.support.annotation.Nullable;

public class BuggyClass {

    @Nullable
    private static String nullableProperty = null;

    public static boolean buggyMethod201901211437() {
        return nullableProperty.equals("");
    }

}
