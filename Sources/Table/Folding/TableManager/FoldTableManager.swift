import Foundation

open class FoldTableManager: TableManager {
    public var singleSelection: Bool = true
    public var shouldScrollToOpen: Bool = true

    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)

        if let section = data[indexPath.section] as? FoldTableSection {
            let diff = section.didChangeFold(to: section.state.next)
            diff?.apply(for: indexPath.section, tableView: tableView)

            if shouldScrollToOpen, section.state == .open {
                let lastItemIndexPath = IndexPath(item: section.count - 1, section: indexPath.section)
                tableView.scrollToRow(
                    at: lastItemIndexPath,
                    at: .none,
                    animated: true
                )
            }
        }

        if singleSelection {
            closeCells(except: indexPath.section)
        }
    }

    open func closeCells(except exceptSection: Int) {
        let elementsToDeselect = data
            .enumerated()
            .lazy
            .compactMap { (offset, element) -> (FoldTableSection, Int)? in
                guard let section = element as? FoldTableSection else { return nil }
                return (section, offset)
            }
            .filter { $0.1 != exceptSection }
            .filter { $0.0.state == .open }
        for (section, sectionIndex) in elementsToDeselect {
            let diff = section.didChangeFold(to: .close)
            diff?.apply(for: sectionIndex, tableView: tableView)
        }
    }
}
