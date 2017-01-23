# Chicago Libraries and ChicagoLibraryKit
<p align="center"><img src="Assets/logo.png" alt="Logo" width=128 height=128></p>

[![Swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat)](https://developer.apple.com/swift/)
![Platforms](https://img.shields.io/cocoapods/p/StepFlow.svg?style=flat)

![Podspec](https://img.shields.io/cocoapods/v/StepFlow.svg)
[![License](https://img.shields.io/cocoapods/l/StepFlow.svg)](https://github.com/Swiftification/StepFlow/master/LICENSE)

[![Twitter](https://img.shields.io/badge/twitter-@VinceDavis-blue.svg?style=flat)](http://twitter.com/Vincedavis)

This is a swift app that you can use to find libraries in Chicago. It was built using CocoaPods.

## Getting Started

Take a look at Demo project or the Playgrounds.

## Features

- [x] List Chicago libraries.
- [x] View Detail info about the library.
- [x] Get times of operation.
- [x] View library on map.

## Todo

- [ ] Make it look pretty

## Installation

* Download or clone this repo.
* Run `pod install` from inside project folder.
* Open project with ChicagoLibrariesiOS.workspace file
* Build and Run

## Using ChicagoLibraryKit code

```swift
let libraryKit = ChicagoLibraryKit()
libraryKit.getLibraries() { result in
    switch result {
    case let .success(libraries):
        print("libraries - \(libraries)")
    case let .error(error):
        print("error - \(error)")
    }
}
```

## Requirements

* ARC
* iOS >= 10.0
* WatchOS >= 3.0
* Xcode 8
* CocoaPods

## License

ChicagoLibrariesiOS & ChicagoLibraryKit is available under the MIT License (MIT)

Copyright (c) 2016 Vince Davis (http://vincedavis.com)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
