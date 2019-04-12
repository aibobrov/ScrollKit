import ScrollKit

final class DetailFoldCellViewModel: TableCellViewModel {
    typealias CellType = DetailFoldCell

    let data: Data
    init(data: Data) {
        self.data = data
    }

    func configure(cell: DetailFoldCell) {
        cell.label.text = String(data.value)
    }

    var height: CGFloat? {
        return 30
    }
}
