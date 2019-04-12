import Foundation

open class PageTableManager: TableManager {
    open func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isLastPath(for: indexPath),
            let viewModel = data.object(for: indexPath) as? CellViewModelDisplayable {
            viewModel.willDisplayAny(cell)
        }
    }

    open func isLastPath(for indexPath: IndexPath) -> Bool {
        return !data[indexPath.section].indices.contains(indexPath.item + 1)
    }
}
