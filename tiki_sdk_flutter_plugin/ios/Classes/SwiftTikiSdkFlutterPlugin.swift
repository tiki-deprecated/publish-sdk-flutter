import Flutter
import UIKit

public class SwiftTikiSdkFlutterPlugin: NSObject, FlutterPlugin {

    var requestCallbacks: Dictionary<String, () -> Unit> = [:]
    var blockCallbacks: Dictionary<String, (String) -> Unit> = [:]

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "tiki_sdk_flutter", binaryMessenger: registrar.messenger())
        let instance = SwiftTikiSdkFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
            case "callRequest" : callRequest(call: call, result: result)
            case "blockRequest" : blockRequest(call: call, result: result)
        default : result(FlutterError(code: "-1", message: "Not implemented", details: nil))
        }
    }

    private func callRequest(call: FlutterMethodCall, result: FlutterResult){
        guard let args = call.arguments as? Dictionary<String, Any>,
              let requestId = args["requestId"] as? String else {
                  result(FlutterError.init(code:"400", message:"requestId argument is missing", details: nil))
                  return
              }
        guard let callback = requestCallbacks[requestId]
            else{
                result(FlutterError.init(code:"400", message:"invalid requestId", details: nil))
                return
            }
        blockCallbacks.removeValue(forKey: requestId)
        callback()
    }

    private func blockRequest(call: FlutterMethodCall, result: FlutterResult){
        guard let args = call.arguments as? Dictionary<String, Any>,
              let requestId = args["requestId"] as? String,
              let value = args["value"] as? String
              else {
                result(FlutterError.init(code:"400", message:"requestId or value is missing", details: nil))
                return
              }
        guard let callback = blockCallbacks[requestId]
            else{
                result(FlutterError.init(code:"400", message:"invalid requestId", details: nil))
                return
            }
        requestCallbacks.removeValue(forKey: requestId)
        callback(value)
    }
}
