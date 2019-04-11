import ScrollKit

final class MainCellViewModel: TableCellViewModel {
    let data: Int

    init(data: Int) {
        self.data = data
    }

    func configure(cell: MainCell) {
        cell.label.text = String(data)
    }

    var height: CGFloat? {
        return 40
    }
}
