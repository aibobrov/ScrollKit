import UIKit

public protocol TableCellViewModel: CellViewModelSelectable, CellViewModelHeightable {
    associatedtype CellType: UITableViewCell

    /// Method to setup cell.
    ///
    /// - Parameter cell: Cell instance.
    func configure(cell: CellType)

    /// Method indicated that cell has been selected.
    ///
    /// - Parameter cell: Cell instance.
    func didSelect(cell: CellType)
}

public extension TableCellViewModel {
    func configure(cell _: CellType) {}
    func didSelect(cell _: CellType) {}
}

public extension TableCellViewModel {
    static var loadsFromNib: Bool {
        return false
    }

    static var cellAnyType: AnyClass {
        return CellType.self
    }

    func configureAny(_ view: UIView) {
        if let cell = view as? CellType {
            configure(cell: cell)
        } else {
            assertionFailure("Unvalid view type")
        }
    }

    static var identifier: String {
        return CellType.identifier
    }

    func didSelectAny(_ view: UIView) {
        if let cell = view as? CellType {
            didSelect(cell: cell)
        } else {
            assertionFailure("Unvalid view type")
        }
    }
}
