import ScrollKit

final class LoaderCellViewModel: TableCellViewModel {
    typealias CellType = LoaderPage

    var onNextPage: (() -> Void)?

    func willDisplay(cell: CellType) {
        cell.startAnimating()
        onNextPage?()
    }

    var height: CGFloat? {
        return 40
    }
}
