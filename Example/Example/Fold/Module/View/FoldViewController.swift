import ScrollKit
import UIKit

class FoldViewController: UIViewController {
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableManager.tableView = tableView
            tableView.register(MainFoldCellViewModel.self, DetailFoldCellViewModel.self)
        }
    }

    let tableManager = FoldTableManager()
    let viewModel = FoldViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableManager.data.sections = viewModel.sections()
    }
}

enum FoldSection: Int {
    case main = 0
}

private extension FoldTableManager {
    subscript(section: FoldSection) -> TableSection {
        get {
            return data[section.rawValue]
        }
        set {
            data[section.rawValue] = newValue
        }
    }
}
