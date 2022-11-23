---
title: Getting Started
excerpt: See just how easy (and fast) it is to add TIKI to your Flutter app —drop in a data exchange to increase user opt-ins and lower risk.
category: 637e6f07266017008b61b9d2
slug: tiki-sdk-flutter-getting-started
hidden: false
order: 1
next:
  pages:
    - type: ref
      icon: book
      name: View the entire API
      slug: tiki-sdk-flutter-tiki-sdk-flutter-builder
      category: SDK [Flutter]
---

_For native iOS and Android projects, use:_

#### 🤖 Android: [tiki-sdk-android](https://github.com/tiki/tiki-sdk-android)
#### 🍎 iOS: [tiki-sdk-ios](https://github.com/tiki/tiki-sdk-ios)

---
&nbsp;

### Installation

```
 $ flutter pub add tiki_sdk_flutter
```
This will add a line like this to your package's pubspec.yaml (and run an implicit dart pub get):
```
dependencies:
  tiki_sdk_dart: ^0.0.9
```

**Make sure your project's Android minSdkVersion to is set to at least `19`**  

`[project]/android/app/build.gradle`

```
android {
    ...
    defaultConfig {
        ...
        minSdkVersion 19
        ...
    }
}
```

### Usage

#### 1. [Sign up](https://console.mytiki.com) (free) for a TIKI developer account to get an API ID.

#### 2. Initialize the TIKI SDK using [TikiSdkFlutterBuilder](tiki-sdk-dart-tiki-sdk-flutter-builder)

Configuration parameters:
- **origin &#8594; String**  
Included in the on-chain transaction to denote the application of origination (can be overridden in individual requests). It should follow a reversed FQDN syntax. _i.e. com.mycompany.myproduct_


- **databaseDir &#8594; String**  
Defines where the local data (SQLite used for persistence) will be stored. If not set, it defaults to Application Documents Directory.


- **apiId &#8594; String**   
A unique identifier for your account. Create, revoke, and cycle Ids _(not a secret but try and treat it with care)_ at https://mytiki.com.


- **address &#8594; String**   
Set the user address (primarily for restoring the state on launch). If not set, a new key pair and address will be generated for the user.


Example:

```
    TikiSdk tiki = await (TikiSdkBuilder()
          ..origin('com.mycompany.myproduct')
          ..apiKey('565b3268-cdc0-4e5c-94c8-5d8f53d4577c'))
          .build();
```

#### 3. Assign ownership
Data ownership can be assigned to any data point, pool, or stream, creating an immutable, on-chain record.

Parameters:
- **source &#8594; String**  
An identifier in your system corresponding to the raw data. _i.e. a user_id_


- **type &#8594; [TikiSdkDataTypeEnum](tiki-sdk-dart-tiki-sdk-data-type-enum)**  
Point, pool, or stream


- **contains &#8594; List&lt;String>**
A list of metadata tags describing the represented data


- **origin &#8594; String?**  
An optional override of the default origin set during initialization


- **about &#8594; String?**  
An optional description to provide additional context to the transaction. Most typically as human-readable text.

Returns:
- **String**  
The unique transaction id (use to recall the transaction record at any time)

Example:

```
String oid = await tiki.assignOwnership('12345', TikiSdkDataTypeEnum.point, ['email_address']);
```

#### 4. Modify consent
Consent is given (or revoked) for data ownership records. Consent defines "who" the data owner has given utilization rights.

Parameters:
- **ownershipId &#8594; String**  
The transaction id for the ownership grant


- **destination &#8594; [TikiSdkDestination](tiki-sdk-dart-tiki-sdk-destination)**  
A collection of paths and application use cases that consent has been granted (or revoked) for.


- **expiry &#8594; DateTime?**  
The date upon which the consent is no longer valid. If not set, consent is perpetual.


- **reward &#8594; String?**  
An optional definition of a reward promised to the user in exchange for consent.


- **about &#8594; String?**  
An optional description to provide additional context to the transaction. Most typically as human-readable text.

Returns:
- **[ConsentModel](tiki-sdk-dart-consent-model)**  
The modified consent NFT

Example:
```
String cid = await tiki.modifyConsent(oid, const TikiSdkDestination.all());
```

#### 5. Apply consent
Apply consent to a data transaction. If consent is granted for the `source` and `destination` and has not expired, the request is executed.

Parameters:
- **source &#8594; String**  
An identifier in your system corresponding to the raw data. _i.e. a user_id_


- **destination &#8594; TikiSdkDestination**  
The destination(s) and use case(s) for the request.


- **request &#8594; Function()**  
The function to execute if consent granted


- **onBlocked &#8594; Function(String)?**  
An optional function to execute if consent is denied.


- **origin &#8594; String?**  
An optional override of the default origin set during initialization

Returns:
- **Future&lt;void>**

Example:
```
await tiki.applyConsent('12345', const TikiSdkDestination.all(),
          () => print('Consent Approved. Send data to backend.')
```