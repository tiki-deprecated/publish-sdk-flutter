import Foundation
public struct TikiSdkFlutterDestination:Codable {
    public var uses: Array<String> = []
    public var paths: Array<String> = []
    
    public static func fromJson(jsonString : String) -> TikiSdkFlutterDestination{
        let decoder = JSONDecoder()
        do {
            let tikiSdkFlutterDestination = try decoder.decode(TikiSdkFlutterDestination.self, from:  Data(jsonString.utf8))
            return tikiSdkFlutterDestination
        } catch {
            objc_exception_rethrow()
        }
    }
    
    public func toJson() -> String{
        let encoder = JSONEncoder()
        do {
            return String(data: try encoder.encode(self), encoding: String.Encoding.utf8) ?? "{uses: [], paths: []}"
        } catch {
            objc_exception_rethrow()
        }
    }
}
