---
title: TikiSdkFlutterBuilder
excerpt: A Flutter specific builder for the [TikiSdk](tiki-sdk-dart-tiki-sdk) object
category: 637e58d4d9362512a6fd7451
slug: tiki-sdk-flutter-tiki-sdk-flutter-builder
hidden: false
order: 1
---

## Constructors

##### TikiSdkFlutterBuilder ()

## Methods

##### origin(String origin) &#8594; void
Included in the on-chain transaction to denote the application of origination (can be overridden in individual requests). It should follow a reversed FQDN syntax.  
_i.e. com.mycompany.myproduct_

##### databaseDir(String databaseDir) &#8594; void
Defines where the local data (SQLite used for persistence) will be stored.  
_Defaults to Application Documents Directory._

##### apiId(String? apiId) &#8594; void
A unique identifier for your account. Create, revoke, and cycle Ids _(not a secret but try and treat it with care)_ at [console.mytiki.com](https://console.mytiki.com).

##### address(String? address) &#8594; void
Set the user `address` (primarily for restoring the state on launch). If not set, a new key pair and address will be generated for the user.

##### build() &#8594; Future&lt;[TikiSdk](tiki-sdk-dart-tiki-sdk)>
Configures required services, building, and returning the [TikiSdk]() object.

Example:
```
    TikiSdk tiki = await (TikiSdkFlutterBuilder()
          ..origin('com.mycompany.myproduct')
          ..apiId('565b3268-cdc0-4e5c-94c8-5d8f53d4577c'))
          .build();
```

















