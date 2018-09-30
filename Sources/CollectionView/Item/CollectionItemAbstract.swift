//
//  CollectionItemAbstract.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 29/09/2018.
//

import Foundation

open class CollectionItemAbstract: Item {
    public typealias ScrollViewCellType = UICollectionViewCell
    public typealias RowActionType = CollectionActionKey

    open var reuseIdentifier: String { abstract() }
    open var cellType: AnyClass { abstract() }
    open var estimatedHeight: CGFloat? { abstract() }
    open var defaultHeight: CGFloat? { abstract() }

    open func configure(_ cell: UICollectionViewCell) { abstract() }
    @discardableResult
    open func invoke(action: CollectionActionKey, cell: UICollectionViewCell?, indexPath: IndexPath, userInfo: [AnyHashable: Any]?) -> Any? { abstract() }
    open func has(action: CollectionActionKey) -> Bool { abstract() }
}
