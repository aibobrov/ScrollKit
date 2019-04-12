import UIKit

public extension UITableView {
    /// Register certain cell view model types.
    ///
    /// - Parameter cellViewModelTypes: Types to register.
    func register(_ cellViewModelTypes: CellViewModel.Type...) {
        for viewModelType in cellViewModelTypes {
            if viewModelType.loadsFromNib {
                let bundle = Bundle(for: viewModelType.cellAnyType)
                let nib = UINib(nibName: viewModelType.identifier, bundle: bundle)
                register(nib, forCellReuseIdentifier: viewModelType.identifier)
            } else {
                register(viewModelType.cellAnyType, forCellReuseIdentifier: viewModelType.identifier)
            }
        }
    }
}

public extension UITableView {
    /// Returns a reusable table-view cell object for the specified reuse identifier and adds it to the table.
    ///
    /// - Parameters:
    ///   - viewModel: View model to dequeue.
    ///   - indexPath: An index path locating a row in tableView.
    /// - Returns: A UITableViewCell object with the associated view model.
    func dequeueReusableCell(with viewModel: CellViewModel, for indexPath: IndexPath) -> UITableViewCell {
        let viewModelType = type(of: viewModel)
        let cell = dequeueReusableCell(withIdentifier: viewModelType.identifier, for: indexPath)
        return cell
    }

    /// Returns a reusable header or footer view located by its view model.
    ///
    /// - Parameter viewModel: View model to dequeue.
    /// - Returns: A UIView object with the associated view model or nil if no such object exists in the reusable view queue.
    func dequeueReusableHeaderFooterView(with viewModel: CellViewModel) -> UIView? {
        let viewModelType = type(of: viewModel)
        return dequeueReusableHeaderFooterView(withIdentifier: viewModelType.identifier)
    }
}
