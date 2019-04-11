import UIKit

public protocol TableCellViewModel: CellViewModelSelectable, CellViewModelHeightable {
    associatedtype CellType: UITableViewCell

    func configure(cell: CellType)
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
