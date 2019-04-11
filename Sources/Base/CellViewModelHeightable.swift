import CoreGraphics

public protocol CellViewModelHeightable {
    var height: CGFloat? { get }
}

public extension CellViewModelHeightable {
    var height: CGFloat? {
        return nil
    }
}
