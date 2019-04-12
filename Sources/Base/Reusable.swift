/// Protocol representing a reusable element.
public protocol Reusable: AnyObject {
    /// Reuse identifier.
    static var identifier: String { get }
}

public extension Reusable {
    static var identifier: String {
        return String(describing: self)
    }
}
