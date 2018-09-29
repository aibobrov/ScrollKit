//
//  TableCellAction.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 29/09/2018.
//

import Foundation

class TableCellAction {
    let cell: UITableViewCell
    let key: ActionKey
    let userInfo: [AnyHashable: Any]?
    public init(key: String, sender: UITableViewCell, userInfo: [AnyHashable: Any]? = nil) {
        self.key = ActionKey(rawValue: key)
        cell = sender
        self.userInfo = userInfo
    }

    public init(key: ActionKey, sender: UITableViewCell, userInfo: [AnyHashable: Any]? = nil) {
        self.key = key
        cell = sender
        self.userInfo = userInfo
    }

    open func invoke() {
        NotificationCenter.default.post(name: .TableViewCellAction, object: self, userInfo: userInfo)
    }
}
