package com.example.iabtcf_consent_info_example

import android.content.SharedPreferences
import android.os.Bundle
import androidx.preference.PreferenceManager
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        PreferenceManager.getDefaultSharedPreferences(context).setupTestConsentInfo()
    }
}

fun SharedPreferences.setupTestConsentInfo() {
    val info = mapOf(
        "IABTCF_CmpSdkID" to 0,
        "IABTCF_CmpSdkVersion" to 0,
        "IABTCF_PolicyVersion" to 2,
        "IABTCF_gdprApplies" to 1,
        "IABTCF_UseNonStandardStacks" to 0,
        "IABTCF_PublisherCC" to "AA",
        "IABTCF_TCString" to "test"
    )

    edit().also {
        info.entries.forEach { (key, value) ->
            when (value) {
                is String -> it.putString(key, value)
                is Int -> it.putInt(key, value)
            }
        }
    }.apply()
}
