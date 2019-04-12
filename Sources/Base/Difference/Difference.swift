public protocol Difference {
    var deleted: [Int]? { get }
    var inserted: [Int]? { get }
    var reloaded: [Int]? { get }

    func combined(with diff: Difference) -> Self

    func apply(for section: Int, tableView: UITableView?)
}

public extension Difference {
    func apply(for section: Int, tableView: UITableView?) {
        tableView?.beginUpdates()
        if let inserted = self.inserted?.map({ IndexPath(item: $0, section: section) }) {
            tableView?.insertRows(at: inserted, with: .automatic)
        }

        if let deleted = self.deleted?.map({ IndexPath(item: $0, section: section) }) {
            tableView?.deleteRows(at: deleted, with: .automatic)
        }

        if let reloaded = self.reloaded?.map({ IndexPath(item: $0, section: section) }) {
            tableView?.reloadRows(at: reloaded, with: .automatic)
        }

        tableView?.endUpdates()
    }
}
