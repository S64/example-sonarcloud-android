package jp.s64.android.example;

import android.support.annotation.Nullable;

public class BuggyClass {

    @Nullable
    public static String nullableMethod() {
        return null;
    }

    public static boolean buggyMethod() {
        return nullableMethod().length() > 0;
    }

}
