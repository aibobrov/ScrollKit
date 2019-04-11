import ScrollKit
import UIKit

protocol CellViewModelDisplayable {
    func willDisplayAny(_ view: UIView)
}

protocol AppTableCellViewModel: TableCellViewModel, CellViewModelDisplayable {
    func willDisplay(cell: CellType)
}

extension AppTableCellViewModel {
    func willDisplayAny(_ view: UIView) {
        if let cell = view as? CellType {
            willDisplay(cell: cell)
        } else {
            assertionFailure()
        }
    }
}
