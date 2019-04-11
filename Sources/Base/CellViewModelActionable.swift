import UIKit

public protocol CellViewModelSelectable: CellViewModel {
    func didSelectAny(_: UIView)
}
