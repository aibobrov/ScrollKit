//
//  TableDirector.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 29/09/2018.
//

import Foundation

open class TableDirector: NSObject {
    public weak var tableView: UITableView? {
        didSet {
            tableView?.delegate = self
            tableView?.dataSource = self
        }
    }

    public var sections: [TableSection] = []

    internal var sectionsIndexTitlesIndexes: [Int]?
    internal var registrar: CellRegistrar?

    public init(tableView: UITableView, shouldUseAutomaticCellRegistration: Bool = false) {
        self.tableView = tableView
        if shouldUseAutomaticCellRegistration {
            registrar = TableCellRegistrar(tableView: tableView)
        }
        super.init()

        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveAction(_:)), name: .TableViewCellAction, object: nil)
    }

    public func reload() {
        tableView?.reloadData()
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
