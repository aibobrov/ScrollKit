//
//  TableDirector.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 29/09/2018.
//

import Foundation

/*
	Main class responsible for table view's delegate and data source.
*/
open class TableDirector: NSObject {
    public weak var tableView: UITableView?

    public var sections: [TableSection] = []

    internal var sectionsIndexTitlesIndexes: [Int]?
    internal var registrar: CellRegistrar?

    public init(tableView: UITableView, shouldUseAutomaticCellRegistration: Bool = false) {
        self.tableView = tableView

        if shouldUseAutomaticCellRegistration {
            registrar = TableCellRegistrar(tableView: tableView)
        }
        super.init()

        tableView.delegate = self
        tableView.dataSource = self

        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveAction(_:)), name: .TableViewCellAction, object: nil)
    }

    @discardableResult
    public func reload() -> Self {
        tableView?.reloadData()
        return self
    }

    public subscript(indexPath: IndexPath) -> TableItemAbstract {
        get {
            return sections[indexPath.section].items[indexPath.row]
        }
        set {
            sections[indexPath.section].items[indexPath.row] = newValue
        }
    }

    @objc func didReceiveAction(_ notification: Notification) {
        guard let action = notification.object as? TableCellAction, let indexPath = tableView?.indexPath(for: action.cell) else { return }
        self[indexPath].invoke(action: action.key, cell: action.cell, indexPath: indexPath, userInfo: nil)
    }
}

extension TableDirector: Collection {
    public typealias Index = Array<TableSection>.Index
    public typealias Element = TableSection

    public var startIndex: Index {
        return sections.startIndex
    }

    public var endIndex: Index {
        return sections.endIndex
    }

    public func index(after i: Index) -> Index {
        return sections.index(after: i)
    }

    public subscript(position: Index) -> Element {
        get {
            return sections[position]
        }
        set {
            sections[position] = newValue
        }
    }
}

extension TableDirector {
    @discardableResult
    open func append(section: TableSection) -> Self {
        append(sections: [section])
        return self
    }

    @discardableResult
    open func append(sections: [TableSection]) -> Self {
        self.sections.append(contentsOf: sections)
        return self
    }

    @discardableResult
    open func append(items: [TableItemAbstract]) -> Self {
        append(section: TableSection(items: items))
        return self
    }

    @discardableResult
    open func insert(section: TableSection, at index: Int) -> Self {
        sections.insert(section, at: index)
        return self
    }

    @discardableResult
    open func replaceSection(at index: Int, with section: TableSection) -> Self {
        if index < sections.count {
            sections[index] = section
        }
        return self
    }

    @discardableResult
    open func delete(sectionAt index: Int) -> Self {
        sections.remove(at: index)
        return self
    }

    @discardableResult
    open func remove(sectionAt index: Int) -> Self {
        return delete(sectionAt: index)
    }

    @discardableResult
    open func clear() -> Self {
        sections.removeAll()
        return self
    }
}
