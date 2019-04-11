import CoreGraphics

/// Protocol representing cell view model with custom height.
public protocol CellViewModelHeightable {
    /// Height of cell.
    var height: CGFloat? { get }
}

public extension CellViewModelHeightable {
    var height: CGFloat? {
        return nil
    }
}
