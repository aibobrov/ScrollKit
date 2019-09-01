import ScrollKit

final class MainPageCellViewModel: TableCellViewModel, CellViewModelHeightable {
    let data: Data

    init(data: Data) {
        self.data = data
    }

    func configure(cell: MainPageCell) {
        cell.label.text = String(data.value)
    }

    var height: CGFloat? {
        return 70
    }
}
