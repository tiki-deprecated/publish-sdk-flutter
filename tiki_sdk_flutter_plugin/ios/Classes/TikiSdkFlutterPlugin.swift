import Flutter
import Promises

public class TikiSdkFlutterPlugin{
    var promises: Dictionary<String, Promise<String?>> = [:]
    var methodChannel: FlutterMethodChannel

    public init(methodChannel: FlutterMethodChannel){
        self.methodChannel = methodChannel
    }

    public func assignOwnership(
        source: String,
        type: String,
        contains: Array<String>,
        origin: String? = nil
    ) async throws -> String?  {

        let requestId = UUID().uuidString
        methodChannel.invokeMethod(
            "assignOwnership", arguments: [
                "requestId" : requestId,
                "source" : source,
                "type" : type,
                "contains" : contains,
                "origin" : origin as Any
            ])
        let promise = Promise<String?>.pending()
        promises[requestId] = promise
        return try awaitPromise(promise)
    }

    public func modifyConsent(
        source: String,
        destination: TikiSdkFlutterDestination,
        about: String?,
        reward: String?
    ) async throws -> String?  {
        let requestId = UUID().uuidString
        methodChannel.invokeMethod(
            "modifyConsent", arguments: [
                "requestId" : requestId,
                "source" : source,
                "destination" : destination.toJson(),
                "about" : about,
                "reward" : reward,
                ]
        )
        let promise = Promise<String?>.pending()
        promises[requestId] = promise
        return try awaitPromise(promise)
    }

    public func getConsent(
        source: String,
        origin: String? = nil
    ) async throws -> String?  {
        let requestId = UUID().uuidString
        methodChannel.invokeMethod(
            "getConsent",  arguments: [
                "requestId" : requestId,
                "source" : source,
                "origin" : origin as Any
            ]
        )
        let promise = Promise<String?>.pending()
        promises[requestId] = promise
        return try awaitPromise(promise)
    }

    public func applyConsent(
        source: String,
        destination: TikiSdkFlutterDestination,
        request: (String?) -> Void,
        onBlock: (String) -> Void
    )  async throws -> Void  {
        let requestId = UUID().uuidString
        methodChannel.invokeMethod(
            "applyConsent",  arguments: [
                "requestId" : requestId,
                "source" : source,
                "destination" : destination.toJson(),
            ]
        )
        do {
            let promise = Promise<String?>.pending()
            let response = try awaitPromise(promise)
            return request(response)
        } catch {
            return onBlock("no consent")
        }
    }
}
