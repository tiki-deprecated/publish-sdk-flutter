package com.mytiki.tiki_sdk_flutter_plugin

import org.json.JSONObject
import java.util.*

data class TikiSdkConsent(
    /**
     * Transaction ID corresponding to the ownership mint for the data source.
     */
    val ownershipId: String,

    /**
     *  The identifier of the paths and use cases for this consent.
     */
    val destination: TikiSdkDestination,

    /**
     *  Optional description of the consent.
     */
    val about: String,

    /**
     *  Optional reward description the user will receive for this consent.
     */
    val reward: String,

    /**
     *  The transaction id of this registry.
     */
    val transactionId: String,

    /**
     *  The Consent expiration date. Null for no expiration.
     */
    val expiry: GregorianCalendar
) {
    companion object {
        fun fromJson(jsonString: String): TikiSdkConsent {
            val jsonObject = JSONObject(jsonString)
            val ownershipId: String = jsonObject.getString("ownershipId")
            val destination: String = jsonObject.getString("destination")
            val about: String = jsonObject.getString("about")
            val reward: String = jsonObject.getString("reward")
            val transactionId: String = jsonObject.getString("transactionId")
            val expiry: String = jsonObject.getString("expiry")
            val dateTime = GregorianCalendar()
            dateTime.timeInMillis = expiry.toLong()
            return TikiSdkConsent(
                ownershipId,
                TikiSdkDestination.fromJson(destination),
                about,
                reward,
                transactionId,
                dateTime
            )
        }
    }

}