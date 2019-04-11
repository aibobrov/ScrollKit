import ScrollKit

final class LoaderCellViewModel: AppTableCellViewModel {
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
