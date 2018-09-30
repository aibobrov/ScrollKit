//
//  TableSectionAbstract.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 29/09/2018.
//

import Foundation

open class TableSectionAbstract: Section {
    public typealias ItemType = TableItemAbstract

    open var items: [TableItemAbstract] = []

    init(items: [TableItemAbstract] = []) {
        self.items = items
    }
}

extension TableSectionAbstract: Collection {
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
