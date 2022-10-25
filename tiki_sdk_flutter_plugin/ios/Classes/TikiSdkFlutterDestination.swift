import Foundation
struct TikiSdkFlutterDestination:Codable {
    var uses: Array<String> = []
    var paths: Array<String> = []
    
    static func fromJson(jsonString : String) -> TikiSdkFlutterDestination{
        let decoder = JSONDecoder()
        do {
            let tikiSdkFlutterDestination = try decoder.decode(TikiSdkFlutterDestination.self, from:  Data(jsonString.utf8))
            return tikiSdkFlutterDestination
        } catch {
            objc_exception_rethrow()
        }
    }
    
    func toJson() -> String{
        let encoder = JSONEncoder()
        do {
            return String(data: try encoder.encode(self), encoding: String.Encoding.utf8) ?? "{uses: [], paths: []}"
        } catch {
            objc_exception_rethrow()
        }
    }
}
