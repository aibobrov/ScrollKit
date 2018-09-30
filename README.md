# ScrollKit

<p align="left">
<a href="https://travis-ci.org/artbobrov/ScrollKit"><img src="https://travis-ci.org/artbobrov/ScrollKit.svg?branch=master" alt="Build status" /></a>
<img src="https://img.shields.io/badge/platform-iOS-blue.svg?style=flat" alt="Platform iOS" />
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/swift4-compatible-4BC51D.svg?style=flat" alt="Swift 4 compatible" /></a>
<a href="https://github.com/Carthage/Carthage"><img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" alt="Carthage compatible" /></a>
<a href="https://cocoapods.org/pods/XLActionController"><img src="https://img.shields.io/cocoapods/v/ScrollKit.svg" alt="CocoaPods compatible" /></a>
<a href="https://raw.githubusercontent.com/artbobrov/ScrollKit/master/LICENSE"><img src="http://img.shields.io/badge/license-MIT-blue.svg?style=flat" alt="License: MIT" /></a>
</p>

## Introduction

ScrollKit is a library to manage your UICollectionView and UITableView data.
Heavily inspired by [TableKit](https://github.com/maxsokolov/TableKit.git).

## Usage

```swift
import ScrollKit

let director = TableDirector(tableView: tableView)
let rows = elements.map { TableRows<MyTableViewCell>(item: $0) }
director.append(rows: rows).reload()
```

## Requirements

* iOS 9.0+
* Xcode 8.0+

## Getting involved

* If you **want to contribute** please feel free to **submit pull requests**.
* If you **have a feature request** please **open an issue**.

## Examples

Follow these 3 steps to run Example project: clone ScrollKit repository, open ScrollKit workspace and run the *Example* project.

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects.

To install ScrollKit, simply add the following line to your Podfile:

```ruby
pod 'ScrollKit', '~> 0.9'
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a simple, decentralized dependency manager for Cocoa.

To install ScrollKit, simply add the following line to your Cartfile:

```ogdl
github "artbobrov/ScrollKit" ~> 0.9
```

## Author

* [@artbobrov](https://github.com/artbobrov)
