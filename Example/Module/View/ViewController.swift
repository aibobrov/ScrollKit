//
//  ViewController.swift
//  Example
//
//  Copyright © 2018. All rights reserved.
//

import ScrollKit
import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableManager.tableView = tableView
            tableView.register(MainCellViewModel.self, LoaderCellViewModel.self)
            let section = TableSection([])
            tableManager.data.append(section)
            tableManager.reloadData()
        }
    }

    private let tableManager = PageTableManager()
    private let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onNextPage = { [weak self] in
            self?.loadNewPage()
        }
        loadNewPage(with: [viewModel.loader()])
    }

    private func loadNewPage() {
        viewModel.loadNextPage { items in
            DispatchQueue.main.async {
                self.loadNewPage(with: items)
            }
        }
    }

    private func loadNewPage(with items: [CellViewModel]) {
        if tableManager.data.first?.isEmpty == false {
            tableManager[.main].items.removeLast()
        }
        tableManager[.main].append(contentsOf: items)

        tableManager.reloadData()
    }
}
