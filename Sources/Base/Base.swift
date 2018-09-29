//
//  Base.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 29/09/2018.
//

import Foundation

public protocol ItemConfigurable {
    associatedtype ScrollViewCellType: UIView

    func configure(_ cell: ScrollViewCellType)
}

public protocol Actionable {
    associatedtype RowActionType
    associatedtype ScrollViewCellType: UIView

    func invoke(action: RowActionType, cell: ScrollViewCellType?, indexPath: IndexPath, userInfo: [AnyHashable: Any]?) -> Any?
    func has(action: RowActionType) -> Bool
}
