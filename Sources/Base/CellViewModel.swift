import UIKit

public protocol CellViewModel: Reusable {
    static var cellAnyType: AnyClass { get }
    static var loadsFromNib: Bool { get }

    func configureAny(_ view: UIView)
}
