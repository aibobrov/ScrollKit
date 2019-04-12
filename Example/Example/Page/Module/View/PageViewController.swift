import ScrollKit
import UIKit

class PageViewController: UIViewController {
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableManager.tableView = tableView
            tableView.register(MainPageCellViewModel.self, LoaderCellViewModel.self)
            let section = TableSection([])
            tableManager.data.append(section)
            tableManager.reloadData()
        }
    }

    private let tableManager = PageTableManager()
    private let viewModel = PageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onNextPage = { [weak self] in
            self?.loadNewPage()
        }
        showNewPage(with: [viewModel.loader()])
    }

    private func loadNewPage() {
        viewModel.loadNextPage { items in
            DispatchQueue.main.async {
                self.showNewPage(with: items)
            }
        }
    }

    private func showNewPage(with items: [CellViewModel]) {
        if tableManager[.main].isEmpty == false {
            tableManager[.main].items.removeLast()
        }
        tableManager[.main].append(contentsOf: items)

        tableManager.reloadData()
    }
}

enum PageSection: Int {
    case main = 0
}

private extension PageTableManager {
    subscript(section: PageSection) -> TableSection {
        get {
            return data[section.rawValue]
        }
        set {
            data[section.rawValue] = newValue
        }
    }
}
