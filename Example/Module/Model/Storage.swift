import Foundation

final class Storage {
    enum Constant {
        static let pageSize = 20
    }

    static let shared = Storage()

    let values: [Int] = Array(0 ... 100)
    var currentPage = 0

    func next(completion: @escaping ([Int]) -> Void) {
        DispatchQueue.global().async {
            sleep(2)
            guard self.currentPage < self.pageCount else {
                completion([])
                return
            }

            let data = Array(self.values[self.currentPage * Constant.pageSize ..< (self.currentPage + 1) * Constant.pageSize])
            completion(data)
            self.currentPage += 1
        }
    }

    var pageCount: Int {
        return values.count / Constant.pageSize
    }
}
