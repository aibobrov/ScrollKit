import UIKit

open class FoldTableSection: TableSection {
    open var details: Items
    private var main: CellViewModel & FoldCellViewModel

    public init(main: CellViewModel & FoldCellViewModel, details: Items) {
        self.details = details
        self.main = main
        super.init([main], header: nil, footer: nil)
    }

	@discardableResult
    func didChangeFold(to newState: FoldState) -> TableDiff? {
		defer {
			main.didChangeFold(to: newState)
		}
        switch newState {
        case .open:
            items = [main] + details
			return TableDiff(deleted: nil, inserted: Array(1..<items.count))
        case .close:
			defer {
				items = [main]
			}
			return TableDiff(deleted: Array(1..<items.count), inserted: nil)
        case .unavailable:
			return nil
        }
    }

    var state: FoldState {
        return main.state
    }
}
