import UIKit

/// Protocol representing selectable cell view model.
public protocol CellViewModelSelectable: CellViewModel {
    func didSelectAny(_: UIView)
}
