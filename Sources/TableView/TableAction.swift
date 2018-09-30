//
//  TableAction.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 29/09/2018.
//

import Foundation

public struct TableActionKey: ActionKey {
    public let rawValue: String

    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

open class TableItemActionOptions<CellType: Configurable> {
    public let item: CellType.DataType
    public let cell: CellType?
    public let indexPath: IndexPath
    public let userInfo: [AnyHashable: Any]?

    public init(item: CellType.DataType, cell: CellType?, indexPath: IndexPath, userInfo: [AnyHashable: Any]?) {
        self.item = item
        self.cell = cell
        self.indexPath = indexPath
        self.userInfo = userInfo
    }
}

private enum TableItemActionHandler<CellType: Configurable> {
    case voidAction((TableItemActionOptions<CellType>) -> Void)
    case action((TableItemActionOptions<CellType>) -> Any?)

    func invoke(withOptions options: TableItemActionOptions<CellType>) -> Any? {
        switch self {
        case let .voidAction(handler):
            return handler(options)
        case let .action(handler):
            return handler(options)
        }
    }
}

open class TableItemAction<CellType: Configurable> {
    public let type: TableActionKey
    private let handler: TableItemActionHandler<CellType>

    public init(_ type: TableActionKey, handler: @escaping (TableItemActionOptions<CellType>) -> Void) {
        self.handler = .voidAction(handler)
        self.type = type
    }

    public init(_ type: TableActionKey, handler: @escaping (TableItemActionOptions<CellType>) -> Any?) {
        self.handler = .action(handler)
        self.type = type
    }

    public func invoke(on cell: UITableViewCell?, item: CellType.DataType, indexPath: IndexPath, userInfo: [AnyHashable: Any]? = nil) -> Any? {
        return handler.invoke(withOptions: TableItemActionOptions<CellType>(item: item, cell: cell as? CellType, indexPath: indexPath, userInfo: userInfo))
    }
}
