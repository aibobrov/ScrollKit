//
//  CollectionCellAction.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 29/09/2018.
//

import Foundation

public struct CollectionActionKey: ActionKey {
    public let rawValue: String

    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

open class CollectionCellAction {
    let cell: UICollectionViewCell
    let key: CollectionActionKey
    let userInfo: [AnyHashable: Any]?
    public init(key: String, sender: UICollectionViewCell, userInfo: [AnyHashable: Any]? = nil) {
        self.key = CollectionActionKey(rawValue: key)
        cell = sender
        self.userInfo = userInfo
    }

    public init(key: CollectionActionKey, sender: UICollectionViewCell, userInfo: [AnyHashable: Any]? = nil) {
        self.key = key
        cell = sender
        self.userInfo = userInfo
    }

    open func invoke() {
        NotificationCenter.default.post(name: .CollectionViewCellAction, object: self, userInfo: userInfo)
    }
}
