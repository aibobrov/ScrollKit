import ScrollKit

final class MainFoldCellViewModel: FoldTableCellViewModel {
    typealias CellType = MainFoldCell

    var state: FoldState = .close
    let object: Object

    init(object: Object) {
        self.object = object
    }

    func didChangeFold(to newState: FoldState) {
        state = newState
    }

    func configure(cell: MainFoldCell) {
        cell.label.text = object.string
    }

    var height: CGFloat? {
        return 50
    }
}
