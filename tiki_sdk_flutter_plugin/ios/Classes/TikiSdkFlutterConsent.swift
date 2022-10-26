public struct TikiSdkFlutterConsent : Codable{
    /**
     * Transaction ID corresponding to the ownership mint for the data source.
     */
    public var ownershipId: String

    /**
     *  The identifier of the paths and use cases for this consent.
     */
    public var destination: TikiSdkFlutterDestination

    /**
     *  Optional description of the consent.
     */
    public var about: String

    /**
     *  Optional reward description the user will receive for this consent.
     */
    public var reward: String

    /**
     *  The transaction id of this registry.
     */
    public var transactionId: String
    
    /**
     *  The Consent expiration date. Null for no expiration.
     */
    public var expiry: Int

    
    public static func fromJson(jsonData: String) -> TikiSdkFlutterConsent {
        let decoder = JSONDecoder()

        do {
            let tikiSdkFlutterConsent =
            try decoder.decode(TikiSdkFlutterConsent.self, from:  Data(jsonData.utf8))
            return tikiSdkFlutterConsent
        } catch {
            objc_exception_rethrow()
        }
    }

}
