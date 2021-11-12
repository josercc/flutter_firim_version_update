You can prompt that Fir.im has a version that can be upgraded

## Features

### V0.0.1

Automatically obtain the latest version of iOS and Android on Fir.im, compare the current version and prompt to upgrade.

## Getting started

```dart
flutter_firim_version_update: ^0.0.1
```

## Usage

```dart
FirimVersionUpdate(
  apiToken: "",
  child: child,
)
```

### Example

```dart
Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Win+',
    theme: ThemeData(
      appBarTheme: AppBarTheme(
        color: WColor.cffffff().color,
        centerTitle: true,
        titleTextStyle: const TextStyle(color: Colors.black),
      ),
    ),
    home: FirimVersionUpdate(
      apiToken: firimApiToken,
      child: MyPage(),
    ),
  );
}
```

