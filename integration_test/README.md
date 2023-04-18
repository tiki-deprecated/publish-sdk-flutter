## How to run integration tests in Android

1 - Use Flutter version >= 3.7.7

2 - In TIKI SDK Flutter root and run `flutter clean`. It will remove the auto generated files.

3 - Run `flutter pub get` to regenerate the build files.
    The TIKI SDK Flutter is a Flutter Module. These kind of packages auto generates their build files. 
    We need to update those files, instead of changing the gradle in our project.

4 - In `.android/build.gradle` lines 16-30 change the `compileSdkVersion` and `minSdkVersion`to:
```
android {
    compileSdkVersion 33
    defaultConfig {
        minSdkVersion 21
    }
}
```

5 - In .android/app/build.gradle lines  5-19 change `compileSdkVersion`, and `minSdkVersion` to:
```
android {
compileSdkVersion 33

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }

    defaultConfig {
        applicationId "com.mytiki.tiki_sdk_flutter.host"
        minSdkVersion 21
        targetSdkVersion 31
        versionCode 1
        versionName "1.0"
    }
```

6 - In .android/Flutter/build.gradle change the `compileSdkVersion` from `flutter.compileSdkVersion` to `33`.

7 - Run `flutter test integration_test`.