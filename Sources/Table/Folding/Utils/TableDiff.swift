public struct TableDiff {
	public let deleted: [Int]?
	public let inserted: [Int]?

	public func apply(for section: Int,
					  tableView: UITableView) {
		tableView.beginUpdates()
		if let inserted = self.inserted?.map({ IndexPath(item: $0, section: section) }) {
			tableView.insertRows(at: inserted, with: .bottom)
		}

		if let deleted = self.deleted?.map({ IndexPath(item: $0, section: section) }) {
			tableView.deleteRows(at: deleted, with: .top)
		}
		tableView.endUpdates()
	}
}
