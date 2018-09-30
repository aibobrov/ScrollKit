//
//  TableCellAction.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 29/09/2018.
//

import Foundation

public class TableCellAction {
    let cell: UITableViewCell
    let key: TableActionKey
    let userInfo: [AnyHashable: Any]?
    public init(key: String, sender: UITableViewCell, userInfo: [AnyHashable: Any]? = nil) {
        self.key = TableActionKey(rawValue: key)
        cell = sender
        self.userInfo = userInfo
    }

    public init(key: TableActionKey, sender: UITableViewCell, userInfo: [AnyHashable: Any]? = nil) {
        self.key = key
        cell = sender
        self.userInfo = userInfo
    }

    open func invoke() {
        NotificationCenter.default.post(name: .TableViewCellAction, object: self, userInfo: userInfo)
    }
}
