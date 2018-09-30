//
//  CollectionAction.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 29/09/2018.
//

import Foundation

open class CollectionItemActionOptions<CellType: Configurable> {
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

private enum CollectionItemActionHandler<CellType: Configurable> {
    case voidAction((CollectionItemActionOptions<CellType>) -> Void)
    case action((CollectionItemActionOptions<CellType>) -> Any?)

    func invoke(withOptions options: CollectionItemActionOptions<CellType>) -> Any? {
        switch self {
        case let .voidAction(handler):
            return handler(options)
        case let .action(handler):
            return handler(options)
        }
    }
}

open class CollectionItemAction<CellType: Configurable> {
    let type: CollectionActionKey
    private let handler: CollectionItemActionHandler<CellType>

    init(_ type: CollectionActionKey, handler: @escaping (CollectionItemActionOptions<CellType>) -> Void) {
        self.handler = .voidAction(handler)
        self.type = type
    }

    init(_ type: CollectionActionKey, handler: @escaping (CollectionItemActionOptions<CellType>) -> Any?) {
        self.handler = .action(handler)
        self.type = type
    }

    public func invoke(on cell: UICollectionViewCell?, item: CellType.DataType, indexPath: IndexPath, userInfo: [AnyHashable: Any]? = nil) -> Any? {
        return handler.invoke(withOptions: CollectionItemActionOptions<CellType>(item: item, cell: cell as? CellType, indexPath: indexPath, userInfo: userInfo))
    }
}
