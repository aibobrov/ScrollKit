//
//  TableCellRegistrar.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 29/09/2018.
//

import UIKit

class TableCellRegistrar: CellRegistrar {
    private var registeredIdentifiers: Set<String> = []
    private weak var tableView: UITableView?

    init(tableView: UITableView) {
        self.tableView = tableView
    }

    func register(cellType: AnyClass, forCellReuseIdentifier reuseIdentifier: String) {
        guard !registeredIdentifiers.contains(reuseIdentifier) else { return }

        guard tableView?.dequeueReusableCell(withIdentifier: reuseIdentifier) == nil else {
            registeredIdentifiers.insert(reuseIdentifier)
            return
        }

        let bundle = Bundle(for: cellType)
        if let _ = bundle.path(forResource: reuseIdentifier, ofType: "nib") {
            tableView?.register(UINib(nibName: reuseIdentifier, bundle: bundle), forCellReuseIdentifier: reuseIdentifier)
        } else {
            tableView?.register(cellType, forCellReuseIdentifier: reuseIdentifier)
        }

        registeredIdentifiers.insert(reuseIdentifier)
    }
}
