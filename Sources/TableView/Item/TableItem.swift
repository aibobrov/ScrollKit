//
//  TableItem.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 29/09/2018.
//

import Foundation

extension TableActionKey {
    public static let canEdit = TableActionKey("TableViewCanEdit")
}

open class TableItem<CellType: Configurable>: TableItemAbstract where CellType: UITableViewCell {
    open var item: CellType.DataType
    open lazy var actions: [TableActionKey: [TableItemAction<CellType>]] = [:]

    open override var reuseIdentifier: String { return CellType.reuseIdentifier }
    open override var cellType: AnyClass { return CellType.self }
    open override var estimatedHeight: CGFloat? { return CellType.estimatedHeight }
    open override var defaultHeight: CGFloat? { return CellType.defaultHeight }

    public init(item: CellType.DataType, actions: [TableItemAction<CellType>]? = nil, editingActions: [UITableViewRowAction]? = nil) {
        self.item = item
        super.init(editingActions: editingActions)
        actions?.forEach { self.on($0) }
    }

    open override func configure(_ cell: UITableViewCell) {
        (cell as? CellType)?.configure(with: item)
    }

    @discardableResult
    open func on(_ action: TableItemAction<CellType>) -> Self {
        if actions[action.type] == nil {
            actions[action.type] = [action]
        } else {
            actions[action.type]!.append(action)
        }
        return self
    }

    @discardableResult
    open func on<T>(type: TableActionKey, handler: @escaping (_ options: TableItemActionOptions<CellType>) -> T) -> Self {
        return on(TableItemAction<CellType>(type, handler: handler))
    }

    @discardableResult
    open func on(key: String, handler: @escaping (_ options: TableItemActionOptions<CellType>) -> Void) -> Self {
        return on(TableItemAction<CellType>(TableActionKey(rawValue: key), handler: handler))
    }

    open func removeActions(for type: TableActionKey) {
        actions[type] = nil
    }

    open func removeActions(for key: String) {
        actions[TableActionKey(rawValue: key)] = nil
    }

    open override func invoke(action: TableActionKey, cell: UITableViewCell?, indexPath: IndexPath, userInfo: [AnyHashable: Any]? = nil) -> Any? {
        return actions[action]?.compactMap { $0.invoke(on: cell, item: item, indexPath: indexPath, userInfo: userInfo) }.last
    }

    open override func has(action: TableActionKey) -> Bool {
        return actions[action] != nil
    }

    open override func isEditingAllowed(for indexPath: IndexPath) -> Bool {
        if actions[.canEdit] != nil {
            return invoke(action: .canEdit, cell: nil, indexPath: indexPath) as? Bool ?? false
        }
        return editingActions?.isEmpty == false
    }
}
