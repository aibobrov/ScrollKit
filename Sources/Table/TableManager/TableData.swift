import Foundation

open class TableData {
    public typealias Sections = [TableSection]
    public var sections: Sections

    public init(sections: [TableSection] = []) {
        self.sections = sections
    }

    open func object(for indexPath: IndexPath) -> CellViewModel {
        return sections[indexPath.section][indexPath.item]
    }

    open func append(_ element: Element) {
        sections.append(element)
    }

    public func append<S>(contentsOf newElements: S) where Element == S.Element, S: Sequence {
        sections.append(contentsOf: newElements)
    }
}

extension TableData: RandomAccessCollection, MutableCollection {
    public typealias Index = Sections.Index
    public typealias Element = Sections.Element

    public var startIndex: Index { return sections.startIndex }
    public var endIndex: TableData.Sections.Index { return sections.endIndex }

    public subscript(position: Index) -> Element {
        get {
            return sections[position]
        }
        set {
            sections[position] = newValue
        }
    }

    public func index(after i: TableData.Sections.Index) -> Index {
        return sections.index(after: i)
    }
}
