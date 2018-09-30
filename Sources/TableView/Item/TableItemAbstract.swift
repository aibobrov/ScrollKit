//
//  TableItemAbstract.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 29/09/2018.
//

import Foundation

open class TableItemAbstract: Item, EditingActionable {
    public typealias ScrollViewCellType = UITableViewCell
    public typealias RowActionType = TableActionKey

    open var reuseIdentifier: String { abstract() }
    open var cellType: AnyClass { abstract() }
    open var estimatedHeight: CGFloat? { abstract() }
    open var defaultHeight: CGFloat? { abstract() }

    open func configure(_ cell: UITableViewCell) { abstract() }
    @discardableResult
    open func invoke(action: TableActionKey, cell: UITableViewCell?, indexPath: IndexPath, userInfo: [AnyHashable: Any]?) -> Any? { abstract() }
    open func has(action: TableActionKey) -> Bool { abstract() }

    open internal(set) var editingActions: [UITableViewRowAction]?
    open func isEditingAllowed(for indexPath: IndexPath) -> Bool { abstract() }

    public init(editingActions: [UITableViewRowAction]? = nil) {
        self.editingActions = editingActions
    }
}
