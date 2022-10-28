import Flutter
import Promises

public class TikiSdkFlutterChannel: FlutterMethodChannel, FlutterPlugin {

    public static let channelId = "tiki_sdk_flutter"

    public static var channel: FlutterMethodChannel?

    public var plugin: TikiSdkFlutterPlugin? = nil


    public lazy var flutterEngine = FlutterEngine(name: "tiki_sdk_flutter_engine")
    public var methodChannel: FlutterMethodChannel? = nil

    public init(apiKey: String? =  nil, origin: String? = nil) {
        super.init()
        if(methodChannel == nil){
            setupChannel(apiKey: apiKey ?? "", origin: origin ?? "")
        }
    }

    public func buildSdk(apiKey: String, origin: String) {
        plugin = TikiSdkFlutterPlugin(methodChannel: methodChannel!)
        methodChannel!.invokeMethod(
            "build", arguments: [
                "apiKey" : apiKey,
                "origin" : origin
            ]
        )
    }

    @objc(handleMethodCall:result:) public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let requestId = (call.arguments as! Dictionary<String, String>)["requestId"] else {
            result(FlutterError.init(code: "-1", message: "missing requestId argument", details: call.arguments))
            return
        }
        let response = (call.arguments as? Dictionary<String, String>)?["response"]
        switch (call.method) {
            case "success" :
                plugin!.promises[requestId]!.fulfill(response)
            break
            case "error" :
                plugin!.promises[requestId]!.reject(TikiSdkError(message: response))
            break
            default : result(FlutterError(code: "-1", message: "Uninplemented", details: call.arguments))
        }
    }

    @objc(registerWithRegistrar:) public static func register(with registrar: FlutterPluginRegistrar) {
        channel = FlutterMethodChannel(name: channelId, binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(TikiSdkFlutterChannel(), channel: channel!)
    }


    public func setupChannel(apiKey: String, origin: String) {
        if (methodChannel == nil) {
            flutterEngine.run()
            methodChannel = FlutterMethodChannel()
        }
        buildSdk(apiKey: apiKey, origin: origin)
    }

}

public struct TikiSdkError : Error {

    var message: String?

    init(message: String?){
        self.message = message
    }
}