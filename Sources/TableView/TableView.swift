//
//  TableView.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 29/09/2018.
//

import Foundation

public protocol EditingActionable {
    var editingActions: [UITableViewRowAction]? { get }
    func isEditingAllowed(for indexPath: IndexPath) -> Bool
}

public struct TableViewUserInfoKeys: Hashable, Equatable, RawRepresentable {
    public let rawValue: String

    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

public extension Notification.Name {
    static let TableViewCellAction = Notification.Name(rawValue: "TableViewCellAction")
}
