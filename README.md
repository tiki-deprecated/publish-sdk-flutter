# TIKI SDK (Flutter) —Data Licensing
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-4-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

The TIKI SDK for JavaScript makes it easy to add data licensing to your web applications. It's the client-side component that your users will interact with to accept (or decline) data licensing offers. TIKI's SDK creates immutable, digitally signed license records using cryptographic hashing, forming an audit trail. Programmatically consume records and enforce terms client or server-side using developer-friendly data structures and [APIs](https://mytiki.com/reference/getting-started).

This library includes both configurable pre-built UI flows/elements and native low-level APIs for building custom experiences.

**Get started with our 📚 [SDK docs](https://mytiki.com/docs/sdk-overview), or jump right into the 📘 [API reference](https://pub.dev/packages/tiki_sdk_flutter).**

## Installing

_Note: Before you get started, you will need a Publishing ID. It's free to create one; simply log in to our 🧑‍💻 [Developer Console](https://console.mytiki.com) and create a new Project._

Either

Install the dependency using Flutter

```
flutter pub add tiki_sdk_flutter
```

This will add a line like this to your package's `pubspec.yaml` (and run an implicit `flutter pub get`):

```
dependencies:
  tiki_sdk_flutter: ^2.1.6
```

That's it. And yes, it's really that easy.

## Initialization
Initialize the TIKI SDK in minutes with the TIKI pre-built UI and a custom data offer —just 1 builder function.

```
await TikiSdk.config()
  .theme
  	.primaryTextColor(Color(0xFF00B277))
  	.primaryBackgroundColor(Color(0xFFFFFFFF))
  	.secondaryBackgroundColor(Color(0xFFF6F6F6))
  	.accentColor(Color(0xFF00B277))
  	.fontFamily("Space Grotesk")
  	.and()
  .offer
  	.description("Trade your IDFA (kind of like a serial # for your phone) for a discount.")
  	.reward(Image.asset("<path>/reward.png"))
  	.bullet("Learn how our ads perform", true)
  	.bullet("Reach you on other platforms", false)
  	.bullet("Sold to other companies", false)
  	.terms("<path>/terms.md")
  	.ptr("db2fd320-aed0-498e-af19-0be1d9630c63")
  	.tag(TitleTag.deviceId())
  	.use([LicenseUsecase.attribution()])
  	.add()
  .initialize("<your-publishing-id>", "<your-user-id>");
```

Read about styling, selecting metadata, and desiging your offer in our [📚 SDK docs →](https://mytiki.com/docs/sdk-overview).

## UI Flows

The SDK includes 2 pre-built flows: `present()` and `settings()`. Use `present()` to display to the user a new data licensing offer.

```
TikiSdk.present(context);
```

Use `settings()` to render a ...settings screen 😲 where users can change their mind and opt-out of an existing license agreement.

```
TikiSdk.settings(context);
```
# Contributing

- Use [GitHub Issues](https://github.com/tiki/tiki-sdk-flutter/issues) to report any bugs you find or to request enhancements.
- If you'd like to get in touch with our team or other active contributors, pop in our 👾 [Discord](https://discord.gg/tiki).
- Please use [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/) if you intend to add code to this project.

## Project Structure
__

- `/lib`: The primary implementation source for the library.
  - `/ui`: Declarative UI flows and widgets.
  - `/assets`: Bundled assets such as graphics and fonts.
- `/integration_tests`: Requires a device or simulator.
- `/example_app`: Simple example app showing how to get started configuring and adding the SDK to a basic Flutter app.

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://www.linkedin.com/in/ricardolg/"><img src="https://avatars.githubusercontent.com/u/8357343?v=4?s=100" width="100px;" alt="Ricardo Gonçalves"/><br /><sub><b>Ricardo Gonçalves</b></sub></a><br /><a href="https://github.com/tiki/tiki-sdk-flutter/commits?author=ricardobrg" title="Code">💻</a> <a href="https://github.com/tiki/tiki-sdk-flutter/commits?author=ricardobrg" title="Documentation">📖</a> <a href="#example-ricardobrg" title="Examples">💡</a> <a href="#maintenance-ricardobrg" title="Maintenance">🚧</a> <a href="https://github.com/tiki/tiki-sdk-flutter/commits?author=ricardobrg" title="Tests">⚠️</a></td>
    </tr>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="http://mytiki.com"><img src="https://avatars.githubusercontent.com/u/3769672?v=4?s=100" width="100px;" alt="Mike Audi"/><br /><sub><b>Mike Audi</b></sub></a><br /><a href="https://github.com/tiki/tiki-sdk-flutter/commits?author=mike-audi" title="Code">💻</a> <a href="https://github.com/tiki/tiki-sdk-flutter/pulls?q=is%3Apr+reviewed-by%3Amike-audi" title="Reviewed Pull Requests">👀</a></td>
    </tr>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="http://harshit933.github.io"><img src="https://avatars.githubusercontent.com/u/90508384?v=4?s=100" width="100px;" alt="Harshit"/><br /><sub><b>Harshit</b></sub></a><br /><a href="https://github.com/tiki/tiki-sdk-flutter/commits?author=Harshit933" title="Code">💻</a> <a href="https://github.com/tiki/tiki-sdk-flutter/commits?author=Harshit933" title="Tests">⚠️</a></td>
    </tr>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/Vigneshsanath"><img src="https://avatars.githubusercontent.com/u/117610954?v=4?s=100" width="100px;" alt="Vigneshsanath"/><br /><sub><b>Vigneshsanath</b></sub></a><br /><a href="#design-Vigneshsanath" title="Design">🎨</a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!