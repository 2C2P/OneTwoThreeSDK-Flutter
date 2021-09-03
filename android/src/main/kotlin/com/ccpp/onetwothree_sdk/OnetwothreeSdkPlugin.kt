package com.ccpp.onetwothree_sdk

import androidx.annotation.NonNull
import com.ccpp.onetwothreesdk.callback.APIResponseCallback
import com.ccpp.onetwothreesdk.core.OneTwoThreeSDKService
import com.ccpp.onetwothreesdk.model.Buyer
import com.ccpp.onetwothreesdk.model.Merchant
import com.ccpp.onetwothreesdk.model.Transaction
import com.ccpp.onetwothreesdk.model.response.CancelDeeplinkResponse
import com.ccpp.onetwothreesdk.model.response.GetDeeplinkStatusResponse
import com.ccpp.onetwothreesdk.model.response.StartDeeplinkResponse
import com.google.gson.Gson
import com.google.gson.JsonSyntaxException
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** OneTwoThreeSDKPlugin */
class OneTwoThreeSDKPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "onetwothree_sdk")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }
            "initialize" -> {
                initialize(call, result)
            }
            "startDeeplink" -> {
                startDeeplink(call, result)
            }
            "getDeeplinkStatus" -> {
                getDeeplinkStatus(call, result)
            }
            "cancelDeeplink" -> {
                cancelDeeplink(call, result)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun initialize(@NonNull call: MethodCall, @NonNull result: Result) {
        val isProd = call.argument<Boolean>("isProduction") ?: false
        val checkSumKey = call.argument<String>("checkSumKey") ?: ""
        val publicKey = call.argument<String>("publicKey") ?: ""
        val privateKey = call.argument<String>("privateKey") ?: ""
        val passphrase = call.argument<String>("passphrase") ?: ""
        val bksPassphrase = call.argument<String>("bksPassphrase") ?: ""

        OneTwoThreeSDKService.initialize(
            isProduction = isProd,
            checkSumKey = checkSumKey,
            publicKey = publicKey,
            privateKey = privateKey,
            passphrase = passphrase,
            bksPassphrase = bksPassphrase
        )

        // Return result to flutter
        result.success(true)
    }

    private fun startDeeplink(@NonNull call: MethodCall, @NonNull result: Result) {
        val jsonMerchant = call.argument<String>("merchant") ?: "{}"
        val jsonTransaction = call.argument<String>("transaction") ?: "{}"
        val jsonBuyer = call.argument<String>("buyer") ?: "{}"

        val merchant = try {
            Gson().fromJson<Merchant>(jsonMerchant, Merchant::class.java)
        } catch (e: JsonSyntaxException) {
            result.error("900", "Parse merchant object failed", null)
            return
        }
        val transaction = try {
            Gson().fromJson<Transaction>(jsonTransaction, Transaction::class.java)
        } catch (e: JsonSyntaxException) {
            result.error("900", "Parse transaction object failed", null)
            return
        }
        val buyer = try {
            Gson().fromJson<Buyer>(jsonBuyer, Buyer::class.java)
        } catch (e: JsonSyntaxException) {
            result.error("900", "Parse buyer object failed", null)
            return
        }

        transaction.userDefined1 = transaction.userDefined1 ?: ""
        transaction.userDefined2 = transaction.userDefined2 ?: ""
        transaction.userDefined3 = transaction.userDefined3 ?: ""
        transaction.userDefined4 = transaction.userDefined4 ?: ""
        transaction.userDefined5 = transaction.userDefined5 ?: ""

        OneTwoThreeSDKService.startDeeplink(merchant, transaction, buyer,
            object : APIResponseCallback<StartDeeplinkResponse> {
                override fun onResponse(response: StartDeeplinkResponse) {
                    val json = Gson().toJson(response)
                    result.success(json)
                }

                override fun onFailure(error: Throwable?) {
                    result.error("999", error?.localizedMessage, error)
                }
            })
    }

    private fun getDeeplinkStatus(@NonNull call: MethodCall, @NonNull result: Result) {
        val merchantId = call.argument<String>("merchantId") ?: ""
        val paymentCode = call.argument<String>("paymentCode") ?: ""
        val merchantReference = call.argument<String>("merchantReference") ?: ""

        OneTwoThreeSDKService.getDeeplinkStatus(merchantId, paymentCode, merchantReference,
            object : APIResponseCallback<GetDeeplinkStatusResponse> {
                override fun onResponse(response: GetDeeplinkStatusResponse) {
                    val json = Gson().toJson(response)
                    result.success(json)
                }

                override fun onFailure(error: Throwable?) {
                    result.error("999", error?.localizedMessage, error)
                }
            })
    }

    private fun cancelDeeplink(@NonNull call: MethodCall, @NonNull result: Result) {
        val merchantId = call.argument<String>("merchantId") ?: ""
        val paymentCode = call.argument<String>("paymentCode") ?: ""
        val merchantReference = call.argument<String>("merchantReference") ?: ""

        OneTwoThreeSDKService.cancelDeeplink(merchantId, paymentCode, merchantReference,
            object : APIResponseCallback<CancelDeeplinkResponse> {
                override fun onResponse(response: CancelDeeplinkResponse) {
                    val json = Gson().toJson(response)
                    result.success(json)
                }

                override fun onFailure(error: Throwable?) {
                    result.error("999", error?.localizedMessage, error)
                }
            })
    }
}
