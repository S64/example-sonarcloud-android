package jp.s64.android.example;

import android.support.annotation.Nullable;

public class BuggyCode {

    @Nullable
    private static final String nullableString = null;

    public boolean buggyMethod() {
        return nullableString.contains("");
    }

}
