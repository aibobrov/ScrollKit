import Foundation

final class Storage {
    enum Constant {
        static let pageSize = 20
    }

    static let shared = Storage()

    let values: [Data] = (0 ... 100).map(Data.init)
    var currentPage = 0

    func next(completion: @escaping (Page) -> Void) {
        DispatchQueue.global().async {
            sleep(2)
            guard self.currentPage < self.pageCount else {
                completion(.empty)
                return
            }

            let data = Array(self.values[self.currentPage * Constant.pageSize ..< (self.currentPage + 1) * Constant.pageSize])
            completion(self.page(for: data))

            self.currentPage += 1
        }
    }

    var pageCount: Int {
        return values.count / Constant.pageSize
    }

    private func page(for data: [Data]) -> Page {
        if data.count < Constant.pageSize {
            return .last(data: data)
        }
        return .content(data: data)
    }
}
