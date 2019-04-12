import Foundation

public protocol FoldCellViewModel {
    var state: FoldState { get }

    func didChangeFold(to newState: FoldState)
}
