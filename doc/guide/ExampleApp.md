---
title: Example App
excerpt: Getting started with the TIKI SDK Flutter sample application
category: 637e6f07266017008b61b9d2
parentDoc: 6398e046fff22900a5284a72
slug: tiki-sdk-flutter-example-app
hidden: false
order: 2
---

To be able to run the TIKI SDK Flutter sample application you need to have Flutter installed and configured locally. For instructions on how to install Flutter check the [official documentation](https://docs.flutter.dev/get-started/install).

1. Clone the TIKI SDK Flutter repository.

`git clone https://github.com/tiki/tiki-sdk-flutter.git`

2. Open the `example_app` folder in Android Studio or VSCode.

3.	Run `flutter pug get` to download the dependencies.

4.	Run the app in an emulator/simulator or physical device.

## SDK initialization

The first initialization of the SDK is done without passing a wallet address as a parameter This tells the TIKI SDK to create a new wallet on startup.

#### example_app/lib/wallet/service.dart - lines 20 to 27

```
Future<void> loadTikiSdk([String? address]) async {
    TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder()
      ..origin(model.origin)
      ..apiId(model.apiId);
    if (address != null) builder.address(address);
    model.tikiSdk = await builder.build();
    if (address == null) {
      model.wallets.add(model.tikiSdk!.address);
    }
    ...
}
```

When the user presses the floating action button in the lower right hand corner of the Wallets screen, a new wallet is created. When TIKI SDK Flutter is initialized without an address, a new wallet is created with a random unique address saved in the list of wallets.


##### example_app/lib/wallet/layout_list.dart - lines 54 to 60

```
floatingActionButton: FloatingActionButton(
    onPressed: () {
      service.loadTikiSdk();
    },
    backgroundColor: Colors.green,
    child: const Icon(Icons.add),
),
```

It is possible to switch wallets while using the application. This functionality is used to simulate SDK initialization on a device where the user has previously created a wallet or in a multi-tenant application. When a valid address is passed as a parameter a new TIKI SDK Flutter instance is created for the wallet.

_Note: The TIKI SDK requires a valid private key for the address, saved in its secure storage. This is managed automatically by the SDK for any wallets created locally._

#### example_app/lib/wallet/layout_list.dart lines 42 to 47

```
onTap: () {
    if (wallet != service.model.tikiSdk?.address) {
      service.loadTikiSdk(wallet);
    }
    Navigator.of(context).pop();
},
```

**Important:** By design, the TIKI SDK does not save the addresses of created wallets. This information must be saved by the application in a local or remote persistence.

## Ownership NFT

When a new wallet is created, the application creates an Ownership NFT for the default data source using the `assignOwnership` call and passing said data source. The source parameter can be any String that uniquely identifies the data. For this example, we use the base64 safe URL of the body of the request.

#### example_app/lib/ownership/service.dart - lines 11 to 22

```
Future<void> getOrAssignOwnership(String source, TikiSdk tikiSdk) async {
    OwnershipModel? ownership = tikiSdk.getOwnership(source);
    if (ownership != null) {
      model.ownership = ownership;
      notifyListeners();
      return;
    }
    await tikiSdk
        .assignOwnership(source, TikiSdkDataTypeEnum.stream, ["Test data"]);
    model.ownership = tikiSdk.getOwnership(source);
    notifyListeners();
}
```

When changing the wallet or changing the body of the request, the Ownership of the new source is loaded. For this, we use the `getOwnership` method. If an Ownership NFT is not found, a new one is created and uploaded.

## Consent NFT

In the sample application, for convenience, we auto-create a Consent NFT on wallet initialization. The requested URL is used as the `TikiSdkDestination` path, and the method is marked as the use case.

#### example_app/lib/consent/service.dart - lines 30-32

```
consent = await tikiSdk.modifyConsent(
    Bytes.base64UrlEncode(ownershipId),
    allow ? destination : const TikiSdkDestination.none());
```


Additional Consent NFTs are created when the user turns the _"toggle consent"_ switch on or off. When changing other destination data, the Consent NFT is not modified.

## Outbound Requests

The example app executes an HTTP request in the time interval defined in the destination screen. Before each request, the app calls the `applyConsent` method from TIKI SDK. If Consent has been given, the request is executed. If not, the request is denied and a blocked message is showed in the log.

#### example_app/lib/requests/service.dart - lines 32-57

```
Future<void> _makeRequest(
      DestinationModel destinationModel, TikiSdk tikiSdk) async {
    TikiSdkDestination destination = TikiSdkDestination([destinationModel.url],
        uses: [destinationModel.httpMethod]);
    tikiSdk.applyConsent(destinationModel.source, destination, () async {
      try {
        var url = Uri.parse(destinationModel.url);
        http.Response response;
        if (destinationModel.httpMethod == "POST") {
          response =
              await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
        } else {
          response = await http.get(url);
        }
        if (response.statusCode < 200 || response.statusCode > 299) {
          throw HttpException(response.body);
        }
        model.log.add(RequestModel("🟢", response.body));
      } catch (error) {
        model.log.add(RequestModel("🔴", error.toString()));
      }
    }, onBlocked: (reason) {
      model.log.add(RequestModel("🔴", "Blocked: $reason"));
    });
    notifyListeners();
}
```

## Testing

The purpose of this sample app is for developers to try out the core features and become familiar with implementing the TIKI SDK in Flutter. Clone the repository and modify however you want. If you find any bugs, please create issues or send in PRs!

For any questions you can contact the team on [Discord](https://discord.gg/tiki). Have fun!
