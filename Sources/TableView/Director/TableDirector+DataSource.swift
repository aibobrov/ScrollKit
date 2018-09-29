//
//  TableDirector+DataSource.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 29/09/2018.
//

import UIKit

extension ActionKey {
    public static let clickDelete = ActionKey("TableViewClickDelete")
    public static let canMove = ActionKey("TableViewCanMove")
    public static let moveRow = ActionKey("TableViewMoveRow")
}

extension TableViewUserInfoKeys {
    public static let CellMoveDestinationIndexPath = TableViewUserInfoKeys("TableViewCellMoveDestinationIndexPath")
}

extension TableDirector: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self[indexPath]
        registrar?.register(cellType: item.cellType, forCellReuseIdentifier: item.reuseIdentifier)

        let cell = tableView.dequeueReusableCell(withIdentifier: item.reuseIdentifier, for: indexPath)
        item.configure(cell)
        return cell
    }

    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self[indexPath].invoke(action: .clickDelete, cell: tableView.cellForRow(at: indexPath), indexPath: indexPath, userInfo: nil)
        }
    }

    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return self[indexPath].isEditingAllowed(for: indexPath)
    }

    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return self[indexPath].invoke(action: .canMove, cell: tableView.cellForRow(at: indexPath), indexPath: indexPath, userInfo: nil) as? Bool ?? false
    }

    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sections[section].footerTitle
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].headerTitle
    }

    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        self[sourceIndexPath].invoke(action: .moveRow, cell: tableView.cellForRow(at: sourceIndexPath), indexPath: sourceIndexPath, userInfo: [TableViewUserInfoKeys.CellMoveDestinationIndexPath: destinationIndexPath])
    }

    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var indexTitles: [String] = []
        var indexTitlesIndexes: [Int] = []

        sections.enumerated().forEach { index, section in
            if let title = section.indexTitle {
                indexTitles.append(title)
                indexTitlesIndexes.append(index)
            }
        }

        if !indexTitles.isEmpty {
            sectionsIndexTitlesIndexes = indexTitlesIndexes
            return indexTitles
        }
        sectionsIndexTitlesIndexes = nil
        return nil
    }

    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return sectionsIndexTitlesIndexes?[index] ?? 0
    }
}
