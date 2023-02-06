import Flutter
import UIKit
import OneTwoThreeSDK

public class SwiftOneTwoThreeSDKPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "onetwothree_sdk", binaryMessenger: registrar.messenger())
        let instance = SwiftOneTwoThreeSDKPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch (call.method) {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
            break;
        case "initialize":
            initialize(call, result: result)
            break;
        case "startDeeplink":
            startDeeplink(call, result: result)
            break;
        case "getDeeplinkStatus":
            getDeeplinkStatus(call, result: result)
            break;
        case "cancelDeeplink":
            cancelDeeplink(call, result: result)
            break;
        default:
            result(FlutterMethodNotImplemented)
            break;
        }
    }
    
    private func initialize(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let arguments = call.arguments as? Dictionary<String, Any?> else {
            result(nil)
            return
        }
        let isProd = arguments["isProduction"] as? Bool ?? false
        let checkSumKey = arguments["checkSumKey"] as? String ?? ""
        let publicKey = arguments["publicKey"] as? String ?? ""
        let privateKey = arguments["privateKey"] as? String ?? ""
        let passphrase = arguments["passphrase"] as? String ?? ""
        
        SDKConstants.isProduction = isProd
        SDKConstants.checkSumKey = checkSumKey
        SDKConstants.publicKey = publicKey
        SDKConstants.privateKey = privateKey

        // Replacing function is bug from some project. !!!!
        /// Replace whitespace in front of multiline key.
//        SDKConstants.publicKey = publicKey.replacingOccurrences(of: "(^\\s+)|(\n\\s+)", with: "\n", options: .regularExpression).trimmingCharacters(in: .whitespacesAndNewlines)
//        SDKConstants.privateKey = privateKey.replacingOccurrences(of: "(^\\s+)|(\n\\s+)", with: "\n", options: .regularExpression).trimmingCharacters(in: .whitespacesAndNewlines)
        SDKConstants.passphrase = passphrase
        
        // Return result to flutter
        result(true)
    }
    
    private func startDeeplink(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let arguments = call.arguments as? Dictionary<String, Any?> else {
            result(FlutterError.init(code: "900", message: "Parse arguments object failed", details: nil))
            return
        }
        let jsonMerchant = arguments["merchant"] as? String ?? "{}"
        let jsonTransaction = arguments["transaction"] as? String ?? "{}"
        let jsonBuyer = arguments["buyer"] as? String ?? "{}"
        
        guard let merchant = fromJsonString(jsonMerchant, type: Merchant.self) else {
            result(FlutterError.init(code: "900", message: "Parse merchant object failed", details: nil))
            return
        }
        guard let transaction = fromJsonString(jsonTransaction, type: Transaction.self) else {
            result(FlutterError.init(code: "900", message: "Parse transaction object failed", details: nil))
            return
        }
        guard let buyer = fromJsonString(jsonBuyer, type: Buyer.self) else {
            result(FlutterError.init(code: "900", message: "Parse buyer object failed", details: nil))
            return
        }
        
        SDKConstants.service.startDeeplink(merchant: merchant, transaction: transaction, buyer: buyer, completion: { (response: StartDeeplinkResponse) in
            result(self.toJson(response))
        }, failureBlock: { (error: ErrorEvent) in
            result(FlutterError.init(code: "999", message: error.localizedDescription, details: "\(error)"))
        })
    }
    
    private func getDeeplinkStatus(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let arguments = call.arguments as? Dictionary<String, Any?> else {
            result(FlutterError.init(code: "900", message: "Parse arguments object failed", details: nil))
            return
        }
        let merchantID = arguments["merchantId"] as? String ?? ""
        let paymentCode = arguments["paymentCode"] as? String ?? ""
        let merchantReference = arguments["merchantReference"] as? String ?? ""
        
        SDKConstants.service.getDeeplinkStatus(merchantID: merchantID, paymentCode: paymentCode, merchantReference: merchantReference) { response in
            result(self.toJson(response))
        } failureBlock: { (error: ErrorEvent) in
            result(FlutterError.init(code: "999", message: error.localizedDescription, details: "\(error)"))
        }
    }
    
    private func cancelDeeplink(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let arguments = call.arguments as? Dictionary<String, Any?> else {
            result(FlutterError.init(code: "900", message: "Parse arguments object failed", details: nil))
            return
        }
        let merchantID = arguments["merchantId"] as? String ?? ""
        let paymentCode = arguments["paymentCode"] as? String ?? ""
        let merchantReference = arguments["merchantReference"] as? String ?? ""
        
        SDKConstants.service.cancelDeeplink(merchantID: merchantID, paymentCode: paymentCode, merchantReference: merchantReference) { response in
            result(self.toJson(response))
        } failureBlock: { (error: ErrorEvent) in
            result(FlutterError.init(code: "999", message: error.localizedDescription, details: "\(error)"))
        }
    }
    
    // MARK: - Other function
    
    private func fromJsonString<T: Decodable>(_ json: String, type: T.Type) -> T? {
        guard let jsonData = json.data(using: .utf8) else {  return nil  }
        
        do {
            let result = try JSONDecoder().decode(T.self, from: jsonData)
            return result
            
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func toJson<T: Codable>(_ object: T) -> String? {
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(object)
            return String(data: jsonData, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }
}

internal class SDKConstants {
    static var service: OneTwoThreeSDKService {
        return OneTwoThreeSDKService(
            production: isProduction,
            checksumKey: checkSumKey,
            publicKey: publicKey,
            privateKey: privateKey,
            passphrase: passphrase
        )
    }
    static var isProduction = false
    static var checkSumKey = ""
    static var publicKey = ""
    static var privateKey = ""
    static var passphrase = ""
}
