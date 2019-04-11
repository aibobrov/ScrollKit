import UIKit

open class TableSection {
    public typealias Items = [CellViewModel]

    open var header: CellViewModel?
    open var footer: CellViewModel?
    open var items: Items

    public init(_ items: Items = [], header: CellViewModel? = nil, footer: CellViewModel? = nil) {
        self.items = items
        self.header = header
        self.footer = footer
    }

    open func append(_ element: Element) {
        items.append(element)
    }

    open func append<S>(contentsOf newElements: S) where Element == S.Element, S: Sequence {
        items.append(contentsOf: newElements)
    }
}

extension TableSection: RandomAccessCollection, MutableCollection {
    public typealias Index = Items.Index
    public typealias Element = Items.Element

    public var startIndex: Index { return items.startIndex }
    public var endIndex: TableData.Sections.Index { return items.endIndex }

    public subscript(position: Index) -> Element {
        get {
            return items[position]
        }
        set {
            items[position] = newValue
        }
    }

    public func index(after i: TableData.Sections.Index) -> Index {
        return items.index(after: i)
    }
}
