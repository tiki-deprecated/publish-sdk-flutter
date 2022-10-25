import Flutter
import Promises

class TikiSdkFlutterPlugin{
    var promises: Dictionary<String, Promise<String?>> = [:]
    var methodChannel: FlutterMethodChannel

    init(methodChannel: FlutterMethodChannel){
        self.methodChannel = methodChannel
    }

    func assignOwnership(
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
                "origin" : origin
            ])
        let promise = Promise<String?>.pending()
        promises[requestId] = promise
        return try awaitPromise(promise)
    }

    func modifyConsent(
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

    func getConsent(
        source: String,
        origin: String? = nil
    ) async throws -> String?  {
        let requestId = UUID().uuidString
        methodChannel.invokeMethod(
            "getConsent",  arguments: [
                "requestId" : requestId,
                "source" : source,
                "origin" : origin,
            ]
        )
        let promise = Promise<String?>.pending()
        promises[requestId] = promise
        return try awaitPromise(promise)
    }

    func applyConsent(
        source: String,
        destination: TikiSdkFlutterDestination,
        request: (String?) -> Unit,
        onBlock: (String) -> Unit
    )  async throws -> Unit  {
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