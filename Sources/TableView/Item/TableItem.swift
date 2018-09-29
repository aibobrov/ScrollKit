//
//  TableItem.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 29/09/2018.
//

import Foundation

open class TableItem<CellType: Configurable>: TableItemAbstract where CellType: UITableViewCell {
    open var item: CellType.DataType
    open lazy var actions: [ActionKey: [ItemAction<CellType>]] = [:]

    open override var reuseIdentifier: String { return CellType.reuseIdentifier }
    open override var cellType: AnyClass { return CellType.self }
    open override var estimatedHeight: CGFloat? { return CellType.estimatedHeight }
    open override var defaultHeight: CGFloat? { return CellType.defaultHeight }

    public init(item: CellType.DataType, actions: [ItemAction<CellType>]? = nil, editingActions: [UITableViewRowAction]? = nil) {
        self.item = item
        super.init(editingActions: editingActions)
        actions?.forEach { self.on($0) }
    }

    open override func configure(_ cell: UITableViewCell) {
        (cell as? CellType)?.configure(with: item)
    }

    @discardableResult
    open func on(_ action: ItemAction<CellType>) -> Self {
        if actions[action.type] == nil {
            actions[action.type] = [action]
        } else {
            actions[action.type]!.append(action)
        }
        return self
    }

    @discardableResult
    open func on<T>(type: ActionKey, handler: @escaping (_ options: ItemActionOptions<CellType>) -> T) -> Self {
        return on(ItemAction<CellType>(type, handler: handler))
    }

    @discardableResult
    open func on(key: String, handler: @escaping (_ options: ItemActionOptions<CellType>) -> Void) -> Self {
        return on(ItemAction<CellType>(ActionKey(rawValue: key), handler: handler))
    }

    open func removeActions(for type: ActionKey) {
        actions[type] = nil
    }

    open func removeActions(for key: String) {
        actions[ActionKey(rawValue: key)] = nil
    }

    open override func invoke(action: ActionKey, cell: UITableViewCell?, indexPath: IndexPath, userInfo: [AnyHashable: Any]? = nil) -> Any? {
        return actions[action]?.compactMap { $0.invoke(on: cell, item: item, indexPath: indexPath, userInfo: userInfo) }.last
    }

    open override func has(action: ActionKey) -> Bool {
        return actions[action] != nil
    }
}
