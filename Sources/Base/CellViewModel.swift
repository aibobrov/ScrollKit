import UIKit

/// Basic cell view model protocol.
public protocol CellViewModel: Reusable {
    /// Class of UITableViewCell.
    static var cellAnyType: AnyClass { get }

    /// Indicates whether cell loads from nib.
    static var loadsFromNib: Bool { get }

    func configureAny(_ view: UIView)
}
