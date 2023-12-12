# Time Tracker

A flutter app that retrieves data from an external API , caches it and allows users to save their tasks

## Project Setup

Follow these steps to setup the project:

1. Clone the repository:
2. Navigate to the project directory:
3. Run the following command to install the dependencies: `flutter pub get`
4. Run the following command to generate the files: `flutter pub run build_runner build`
5. Run the following command to run the app: `flutter run`
6. Run the following command to run the tests: `flutter test`

## Implementation

I implemented using the  3.13.0 flutter version fetches tasks from 'https://wookie.codesubmit.io/time-tracking' and allows users Save their tasks it is stored on their device in an efficient manner
such that reading and writing isn't an hassle and it is readily available

it also has an intuitive UI that is designed to fit different screen sizes

## Libraries Used
- [Dio](https://pub.dev/packages/dio) : This package helps with making http requests and makes error handling for requests a breeze
- [Equatable](https://pub.dev/packages/equatable) : Equatable overrides == and hashCode for you so you don't have to waste your time writing lots of boilerplate code.
- [Flutter Bloc](https://pub.dev/packages/flutter_bloc) : Flutter Bloc is a State management package that helps build fast and reactive applications
- [Flutter Lint](https://pub.dev/packages/flutter_lints) : Flutter Lints is a linting package that contains all the flutter recommended best practices to ensure quality coding practices
- [Shimmer](https://pub.dev/packages/shimmer) : Shimmer is a skeleton loader package that helps make Intuitive loaders
- [Hive](https://pub.dev/packages/hive_flutter) : These package helps with making saving information on devices easy i chose it because the data been stored doesn't require any complex relationship as it is simple app
- [dartz](https://pub.dev/packages/dartz) : These package helps with making functional programming easy and also helps with error handling
- [flutter_svg](https://pub.dev/packages/flutter_svg) : These package helps with rendering svg images
- [google_fonts](https://pub.dev/packages/google_fonts) : These package helps with using google fonts in flutter
- [adaptive_theme](https://pub.dev/packages/adaptive_theme) : These package helps with making the app theme adaptive to the device's theme

## Do a critique:
The current implementation isn't perfect it doesn't have a way to edit tasks and it doesn't have a way to delete tasks. adding this would greatly improve the app
