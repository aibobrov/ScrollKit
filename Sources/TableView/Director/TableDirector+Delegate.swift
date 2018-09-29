//
//  TableDirector+Delegate.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 29/09/2018.
//

import Foundation

public extension ActionKey {
    public static let didSelectRow = ActionKey("TableViewDidSelected")
    public static let didDeselectRow = ActionKey("TableViewDidDeselected")
    public static let didHighlightRow = ActionKey("TableViewDidHightlight")
    public static let didUnhighlightRow = ActionKey("TableViewDidUnhightlight")
    public static let willDisplayCell = ActionKey("TableViewWillDisplayCell")
    public static let didEndDisplayingCell = ActionKey("TableViewDidendDisplayingCell")
    public static let shouldHighlightRow = ActionKey("TableViewShouldHighlightRow")
    public static let shouldShowMenuForRow = ActionKey("TableViewShouldShowMenuForRow")
    public static let didEndEditingRow = ActionKey("TableViewDidEndEditingRow")
    public static let accessoryButtonTapped = ActionKey("TableViewAccessoryButtonTapped")
    public static let titleForDeleteConfirmationButton = ActionKey("TableViewTitleForDeleteConfirmationButton")
    public static let canFocusRow = ActionKey("TableViewCanFocusRow")
    public static let willBeginEditingRow = ActionKey("TableViewWillBeginEditingRow")
    public static let willSelectRow = ActionKey("TableViewWillSelectRow")
    public static let willDeselectRow = ActionKey("TableViewWillDeselectRow")
    public static let indentationLevelForRow = ActionKey("TableViewIndentationLevelForRow")
    public static let shouldIndentWhileEditingRow = ActionKey("TableViewShouldIndentWhileEditingRow")
    public static let canDelete = ActionKey("TableViewCanDelete")
    public static let canMoveTo = ActionKey("TableViewCanMoveTo")
    public static let height = ActionKey("TableViewHeight")
}

public extension TableViewUserInfoKeys {
    public static let CellCanMoveProposedIndexPath = ActionKey("TableViewCellCanMoveProposedIndexPath")
}

extension TableDirector: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self[indexPath].invoke(action: .didSelectRow, cell: tableView.cellForRow(at: indexPath), indexPath: indexPath, userInfo: nil)
    }

    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self[indexPath].invoke(action: .didDeselectRow, cell: tableView.cellForRow(at: indexPath), indexPath: indexPath, userInfo: nil)
    }

    public func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        self[indexPath].invoke(action: .didHighlightRow, cell: tableView.cellForRow(at: indexPath), indexPath: indexPath, userInfo: nil)
    }

    public func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }

        self[indexPath].invoke(action: .didEndEditingRow, cell: tableView.cellForRow(at: indexPath), indexPath: indexPath, userInfo: nil)
    }

    public func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        self[indexPath].invoke(action: .didUnhighlightRow, cell: tableView.cellForRow(at: indexPath), indexPath: indexPath, userInfo: nil)
    }

    public func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return self[indexPath].invoke(action: .canFocusRow, cell: tableView.cellForRow(at: indexPath), indexPath: indexPath, userInfo: nil) as! Bool? ?? true
    }

    public func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        self[indexPath].invoke(action: .willBeginEditingRow, cell: tableView.cellForRow(at: indexPath), indexPath: indexPath, userInfo: nil)
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self[indexPath].invoke(action: .height, cell: tableView.cellForRow(at: indexPath), indexPath: indexPath, userInfo: nil) as! CGFloat? ??
            self[indexPath].defaultHeight ?? UITableView.automaticDimension
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return sections[section].footerFactory?(tableView, section)
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sections[section].headerFactory?(tableView, section)
    }

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return sections[section].footerHeight ?? sections[section].footerView?.frame.size.height ?? UITableView.automaticDimension
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].headerHeight ?? sections[section].headerView?.frame.size.height ?? UITableView.automaticDimension
    }

    public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return self[indexPath].invoke(action: .shouldHighlightRow, cell: tableView.cellForRow(at: indexPath), indexPath: indexPath, userInfo: nil) as! Bool? ?? true
    }

    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return self[indexPath].invoke(action: .willSelectRow, cell: tableView.cellForRow(at: indexPath), indexPath: indexPath, userInfo: nil) as! IndexPath?
    }

    public func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        return self[indexPath].invoke(action: .indentationLevelForRow, cell: tableView.cellForRow(at: indexPath), indexPath: indexPath, userInfo: nil) as! Int? ?? 0
    }

    public func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        return self[indexPath].invoke(action: .shouldShowMenuForRow, cell: tableView.cellForRow(at: indexPath), indexPath: indexPath, userInfo: nil) as! Bool? ?? true
    }

    public func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        self[indexPath].invoke(action: .accessoryButtonTapped, cell: tableView.cellForRow(at: indexPath), indexPath: indexPath, userInfo: nil)
    }

    public func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        return self[indexPath].invoke(action: .willDeselectRow, cell: tableView.cellForRow(at: indexPath), indexPath: indexPath, userInfo: nil) as! IndexPath?
    }

    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self[indexPath].defaultHeight ?? self[indexPath].estimatedHeight ?? UITableView.automaticDimension
    }

    public func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return sections[section].estimatedFooterHeight ?? UITableView.automaticDimension
    }

    public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].estimatedHeaderHeight ?? UITableView.automaticDimension
    }

    public func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return self[indexPath].invoke(action: .shouldIndentWhileEditingRow, cell: tableView.cellForRow(at: indexPath), indexPath: indexPath, userInfo: nil) as! Bool? ?? true
    }

    public func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {}

    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {}

    public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if self[indexPath].invoke(action: .canDelete, cell: tableView.cellForRow(at: indexPath), indexPath: indexPath, userInfo: nil) as? Bool ?? false {
            return .delete
        }

        return .none
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self[indexPath].invoke(action: .willDisplayCell, cell: cell, indexPath: indexPath, userInfo: nil)
    }

    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return self[indexPath].editingActions
    }

    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self[indexPath].invoke(action: .didEndDisplayingCell, cell: cell, indexPath: indexPath, userInfo: nil)
    }

    public func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return self[indexPath].invoke(action: .titleForDeleteConfirmationButton, cell: tableView.cellForRow(at: indexPath), indexPath: indexPath, userInfo: nil) as! String?
    }

    public func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        return self[sourceIndexPath].invoke(action: .canMoveTo, cell: tableView.cellForRow(at: sourceIndexPath), indexPath: sourceIndexPath, userInfo: [TableViewUserInfoKeys.CellCanMoveProposedIndexPath: proposedDestinationIndexPath]) as! IndexPath? ?? proposedDestinationIndexPath
    }
}
