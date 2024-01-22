# Flutter BigDog Mobile Project

This Flutter project serves as a starting point for a mobile application named BigDog.

## Getting Started

If this is your first Flutter project, follow these resources to get started:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For detailed information and help on Flutter development, refer to the [online documentation](https://docs.flutter.dev/), which provides tutorials, samples, guidance on mobile development, and a comprehensive API reference.

## Project Structure

The project structure includes the following components:

- `lib/`: Contains the Dart source code for your application.
- `assets/`: This folder contains static assets used by your application.

### Assets

The `assets` folder includes subfolders for specific types of assets:

- `images/`: Store your image assets here.
- `icon/`: Store your application icon or logo here.

```plaintext
flutter_bigdog_project/
|-- lib/
|-- assets/
|   |-- images/
|       |-- example_image.png
|   |-- icon/
|       |-- app_icon.png

flutter pub get
  open -a simulator (to get iOS Simulator)
  flutter run
  flutter run -d chrome --web-renderer html (to see the best output)