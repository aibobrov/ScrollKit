import ScrollKit

final class PageViewModel {
    var onNextPage: (() -> Void)?
    let storage = Storage.shared
    var data: [Data] = []

    func loadNextPage(completion: @escaping ([CellViewModel]) -> Void) {
        storage.next { page in
            self.data.append(contentsOf: page.data)
            completion(self.cells(for: page))
        }
    }

    func loader() -> CellViewModel {
        let loaderViewModel = LoaderCellViewModel()
        loaderViewModel.onNextPage = { [weak self] in
            self?.onNextPage?()
        }
        return loaderViewModel
    }

    private func cells(for page: Page) -> [CellViewModel] {
        switch page {
        case .empty:
            return []
        case let .content(data):
            return data.map(MainPageCellViewModel.init(data:)) + [self.loader()]
        case let .last(data):
            return data.map(MainPageCellViewModel.init(data:))
        }
    }
}
