import UIKit

open class TableManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    open weak var tableView: UITableView? {
        didSet {
			tableView?
				.dataSource?.tableView(<#T##tableView: UITableView##UITableView#>, cellForRowAt: <#T##IndexPath#>)
            tableView?.dataSource = self
            tableView?.delegate = self
        }
    }

    open var data = TableData()

    public init(tableView: UITableView? = nil) {
        self.tableView = tableView
    }

    open func reloadData() {
        tableView?.reloadData()
    }

    // MARK: - UITableView data source

    open func numberOfSections(in _: UITableView) -> Int {
        return data.count
    }

    open func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = data.object(for: indexPath)
        let cell = tableView.dequeueReusableCell(with: viewModel, for: indexPath)
        viewModel.configureAny(cell)
        return cell
    }

    // MARK: - UITableView delegate

    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = data.object(for: indexPath) as? CellViewModelSelectable,
            let cell = tableView.cellForRow(at: indexPath) else { return }

        viewModel.didSelectAny(cell)
    }

    open func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let viewModel = data.object(for: indexPath) as? CellViewModelHeightable
        return viewModel?.height ?? UITableView.automaticDimension
    }

    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = data[section].header,
            let view = tableView.dequeueReusableHeaderFooterView(with: header) else { return nil }
        header.configureAny(view)
        return view
    }

    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = data[section].header,
            let view = tableView.dequeueReusableHeaderFooterView(with: footer) else { return nil }
        footer.configureAny(view)
        return view
    }
}
