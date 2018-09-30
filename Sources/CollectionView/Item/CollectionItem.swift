//
//  CollectionItem.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 29/09/2018.
//

import Foundation

open class CollectionItem<CellType: Configurable>: CollectionItemAbstract where CellType: UICollectionViewCell {
    open var item: CellType.DataType
    open lazy var actions: [CollectionActionKey: [CollectionItemAction<CellType>]] = [:]

    open override var reuseIdentifier: String { return CellType.reuseIdentifier }
    open override var cellType: AnyClass { return CellType.self }
    open override var estimatedHeight: CGFloat? { return CellType.estimatedHeight }
    open override var defaultHeight: CGFloat? { return CellType.defaultHeight }

    public init(item: CellType.DataType, actions: [CollectionItemAction<CellType>]? = nil) {
        self.item = item
        super.init()
        actions?.forEach { self.on($0) }
    }

    open override func configure(_ cell: UICollectionViewCell) {
        (cell as? CellType)?.configure(with: item)
    }

    @discardableResult
    open func on(_ action: CollectionItemAction<CellType>) -> Self {
        if actions[action.type] == nil {
            actions[action.type] = [action]
        } else {
            actions[action.type]!.append(action)
        }
        return self
    }

    @discardableResult
    open func on<T>(type: CollectionActionKey, handler: @escaping (_ options: CollectionItemActionOptions<CellType>) -> T) -> Self {
        return on(CollectionItemAction<CellType>(type, handler: handler))
    }

    @discardableResult
    open func on(key: String, handler: @escaping (_ options: CollectionItemActionOptions<CellType>) -> Void) -> Self {
        return on(CollectionItemAction<CellType>(CollectionActionKey(rawValue: key), handler: handler))
    }

    open func removeActions(for type: CollectionActionKey) {
        actions[type] = nil
    }

    open func removeActions(for key: String) {
        actions[CollectionActionKey(rawValue: key)] = nil
    }

    open override func invoke(action: CollectionActionKey, cell: UICollectionViewCell?, indexPath: IndexPath, userInfo: [AnyHashable: Any]? = nil) -> Any? {
        return actions[action]?.compactMap { $0.invoke(on: cell, item: item, indexPath: indexPath, userInfo: userInfo) }.last
    }

    open override func has(action: CollectionActionKey) -> Bool {
        return actions[action] != nil
    }
}
