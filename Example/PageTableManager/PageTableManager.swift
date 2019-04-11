import ScrollKit

enum SectionType: Int {
    case main = 0
}

final class PageTableManager: TableManager {
    func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isLastPath(for: indexPath),
            let viewModel = data.object(for: indexPath) as? CellViewModelDisplayable {
            viewModel.willDisplayAny(cell)
        }
    }

    private func isLastPath(for indexPath: IndexPath) -> Bool {
        return !data[indexPath.section].indices.contains(indexPath.item + 1)
    }

    subscript(section: SectionType) -> TableSection {
        get {
            return data[section.rawValue]
        }
        set {
            data[section.rawValue] = newValue
        }
    }
}
