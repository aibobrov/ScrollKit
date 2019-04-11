import UIKit

public extension UITableView {
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
    func dequeueReusableCell(with viewModel: CellViewModel, for indexPath: IndexPath) -> UITableViewCell {
        let viewModelType = type(of: viewModel)
        let cell = dequeueReusableCell(withIdentifier: viewModelType.identifier, for: indexPath)
        return cell
    }

    func dequeueReusableHeaderFooterView(with viewModel: CellViewModel) -> UIView? {
        let viewModelType = type(of: viewModel)
        return dequeueReusableHeaderFooterView(withIdentifier: viewModelType.identifier)
    }
}
