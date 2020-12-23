package com.terwesten.gabriel.iabtcf_consent_info

import android.content.SharedPreferences
import android.content.SharedPreferences.OnSharedPreferenceChangeListener
import androidx.annotation.NonNull
import androidx.preference.PreferenceManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel

/** IabtcfConsentInfoPlugin */
class IabtcfConsentInfoPlugin : FlutterPlugin, EventChannel.StreamHandler {
    private lateinit var channel: EventChannel

    private lateinit var sharedPreferences: SharedPreferences

    private var events: EventChannel.EventSink? = null

    private var lastConsentInfoSent: Map<String, Any?>? = null

    private val sharedPreferencesListener = OnSharedPreferenceChangeListener { _, _ ->
        sendConsentInfo()
    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = EventChannel(flutterPluginBinding.binaryMessenger, "com.terwesten.gabriel/iabtcf_consent_info")
        channel.setStreamHandler(this)

        sharedPreferences = PreferenceManager.getDefaultSharedPreferences(flutterPluginBinding.applicationContext)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setStreamHandler(null)
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
        this.events = events
        sendConsentInfo()
        sharedPreferences.registerOnSharedPreferenceChangeListener(sharedPreferencesListener)
    }

    override fun onCancel(arguments: Any?) {
        sharedPreferences.unregisterOnSharedPreferenceChangeListener(sharedPreferencesListener)
        events = null
        lastConsentInfoSent = null
    }

    private fun sendConsentInfo() {
        val consentInfo = getConsentInfo()

        if (lastConsentInfoSent == null || consentInfo != lastConsentInfoSent) {
            lastConsentInfoSent = consentInfo
            events!!.success(consentInfo)
        }
    }

    private fun getConsentInfo(): Map<String, Any?> =
            sharedPreferences.all.filterKeys { it.startsWith("IABTCF_") }
}
