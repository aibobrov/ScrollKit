//
//  Action.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 29/09/2018.
//

import Foundation

public struct ActionKey: Hashable, Equatable, RawRepresentable {
    public let rawValue: String

    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

open class ItemActionOptions<CellType: Configurable> {
    public let item: CellType.DataType
    public let cell: CellType?
    public let indexPath: IndexPath
    public let userInfo: [AnyHashable: Any]?

    init(item: CellType.DataType, cell: CellType?, indexPath: IndexPath, userInfo: [AnyHashable: Any]?) {
        self.item = item
        self.cell = cell
        self.indexPath = indexPath
        self.userInfo = userInfo
    }
}

private enum ItemActionHandler<CellType: Configurable> {
    case voidAction((ItemActionOptions<CellType>) -> Void)
    case action((ItemActionOptions<CellType>) -> Any?)

    func invoke(withOptions options: ItemActionOptions<CellType>) -> Any? {
        switch self {
        case let .voidAction(handler):
            return handler(options)
        case let .action(handler):
            return handler(options)
        }
    }
}

open class ItemAction<CellType: Configurable> {
    let type: ActionKey
    private let handler: ItemActionHandler<CellType>

    init(_ type: ActionKey, handler: @escaping (ItemActionOptions<CellType>) -> Void) {
        self.handler = .voidAction(handler)
        self.type = type
    }

    init(_ type: ActionKey, handler: @escaping (ItemActionOptions<CellType>) -> Any?) {
        self.handler = .action(handler)
        self.type = type
    }

    public func invoke(on cell: UITableViewCell?, item: CellType.DataType, indexPath: IndexPath, userInfo: [AnyHashable: Any]? = nil) -> Any? {
        return handler.invoke(withOptions: ItemActionOptions<CellType>(item: item, cell: cell as? CellType, indexPath: indexPath, userInfo: userInfo))
    }
}
