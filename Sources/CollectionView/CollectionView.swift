//
//  CollectionView.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 30/09/2018.
//

import Foundation

public struct CollectionViewUserInfoKeys: Hashable, Equatable, RawRepresentable {
    public let rawValue: String

    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

public extension Notification.Name {
    public static let CollectionViewCellAction = Notification.Name("CollectionViewCellAction")
}
