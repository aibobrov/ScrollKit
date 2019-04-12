import Foundation

open class FoldTableManager: TableManager {
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)

        if let viewModel = data[indexPath.section] as? FoldTableSection {
            let diff = viewModel.didChangeFold(to: viewModel.state.next)
            diff?.apply(for: indexPath.section, tableView: tableView)
        }
    }
}
