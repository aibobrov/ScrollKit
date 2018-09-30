//
//  CollectionSectionAbstract.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 29/09/2018.
//

import Foundation

open class CollectionSectionAbstract: Section {
    public typealias ItemType = CollectionItemAbstract

    open var items: [CollectionItemAbstract] = []

    public init(items: [CollectionItemAbstract] = []) {
        self.items = items
    }
}

extension CollectionSectionAbstract: Collection {
    public typealias Index = Array<ItemType>.Index
    public typealias Element = ItemType

    public var startIndex: Index {
        return items.startIndex
    }

    public var endIndex: Index {
        return items.endIndex
    }

    public func index(after i: Index) -> Index {
        return items.index(after: i)
    }

    public subscript(position: Index) -> Element {
        get { return items[position] } set { items[position] = newValue }
    }
}
