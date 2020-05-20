#  Clean Architecture Starter for iOS Application
[![Swift 5.2](https://img.shields.io/badge/swift-5.2-blue.svg?style=flat)](https://swift.org/download/)

This project is a start project using a dummy REST API ([JSONPlaceholder](https://jsonplaceholder.typicode.com/))

Developpement Pattern:

- Clean architecture
- MVI

#### Notes

- This project is using SwiftLint.
- Swinject for dependency injection.
-  R.swift is used for ressources access and It's build with SPM in the "BuildTools" folder so no dependencies are required (Thanks to [Tobeas Brennan](https://blog.apptekstudios.com/2019/12/spm-xcode-build-tools/)).
- After cloning this project you may need to renaming it ([Renaming a Project in Xcode](https://medium.com/swlh/renaming-a-project-in-xcode-30d0cd96d3ee)).

## Requirement
this project use the following dependencies:

- [SwiftLint](https://github.com/realm/SwiftLint)


## Requirement installation
#### SwiftLint
```
brew install swiftlint
```

## To do
* [x] Add RemoteLayer.
* [x] Add Router exemple.
* [ ] Add CoreDataLayer.
* [ ] Add UnitTests.

## Reading
Clean Architecture:

- [Clean Architecture and MVVM on iOS](https://tech.olx.com/clean-architecture-and-mvvm-on-ios-c9d167d9f5b3)
- [iOS Architecture Patterns](https://medium.com/ios-os-x-development/ios-architecture-patterns-ecba4c38de52#.ba7q8dcih)

RX:

- [VIPER architecture using RxSwift](https://medium.com/@rida_36291/viper-architecture-using-rxswift-9a006bc7f8f3)

MVI:

- [Model-View-Intent (MVI) using RxSwift on iOS](https://medium.com/@michaellong/model-view-intent-mvi-using-rxswift-on-ios-bf9403bc6961)


## Dependencies
- [Swinject](https://github.com/Swinject/Swinject)
- [RxSwift](https://github.com/ReactiveX/RxSwift)
- [RxAlamofire](https://github.com/RxSwiftCommunity/RxAlamofire)
- [SwifterSwift](https://github.com/SwifterSwift/SwifterSwift)
- [R.Swift](https://github.com/mac-cain13/R.swift)
- [PLogger](https://github.com/phoenisis/PLogger)
- [Gedatsu](https://github.com/bannzai/Gedatsu)
