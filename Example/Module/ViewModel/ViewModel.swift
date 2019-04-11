import ScrollKit

final class ViewModel {
    typealias Data = Int

    var onNextPage: (() -> Void)?
    let storage = Storage.shared
    var data: [Int] = []

    func loadNextPage(completion: @escaping ([CellViewModel]) -> Void) {
        storage.next { models in
            self.data.append(contentsOf: models)
            if models.isEmpty {
                completion([])
            } else {
                completion(models.map(MainCellViewModel.init(data:)) + [self.loader()])
            }
        }
    }

    func loader() -> CellViewModel {
        let loaderViewModel = LoaderCellViewModel()
        loaderViewModel.onNextPage = { [weak self] in
            self?.onNextPage?()
        }
        return loaderViewModel
    }
}
