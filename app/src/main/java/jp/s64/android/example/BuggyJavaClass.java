package jp.s64.android.example;

import android.support.annotation.Nullable;

public class BuggyJavaClass {

    @Nullable
    String nullableMethod() {
        return null;
    }

    boolean buggyMethod() {
        return nullableMethod().concat("test").length() > 0;
    }

}
