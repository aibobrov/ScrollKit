import ScrollKit

final class FoldViewModel {
    let data = [
        Fold(main: Object(string: "Полет МСК-СПБ #1"), data: (0 ..< Int.random(in: 1 ... 4)).map(Data.init)),
        Fold(main: Object(string: "Полет МСК-СПБ #2"), data: (0 ..< Int.random(in: 1 ... 4)).map(Data.init)),
        Fold(main: Object(string: "Полет МСК-СПБ #3"), data: (0 ..< Int.random(in: 1 ... 4)).map(Data.init)),
        Fold(main: Object(string: "Полет МСК-СПБ #4"), data: (0 ..< Int.random(in: 1 ... 4)).map(Data.init)),
        Fold(main: Object(string: "Полет МСК-СПБ #5"), data: (0 ..< Int.random(in: 1 ... 4)).map(Data.init)),
        Fold(main: Object(string: "Полет МСК-СПБ #6"), data: (0 ..< Int.random(in: 1 ... 4)).map(Data.init)),
        Fold(main: Object(string: "Полет МСК-СПБ #8"), data: (0 ..< Int.random(in: 1 ... 4)).map(Data.init)),
        Fold(main: Object(string: "Полет МСК-СПБ #9"), data: (0 ..< Int.random(in: 1 ... 4)).map(Data.init)),
        Fold(main: Object(string: "Полет МСК-СПБ #10"), data: (0 ..< Int.random(in: 1 ... 4)).map(Data.init)),
        Fold(main: Object(string: "Полет МСК-СПБ #11"), data: (0 ..< Int.random(in: 1 ... 4)).map(Data.init)),
        Fold(main: Object(string: "Полет МСК-СПБ #12"), data: (0 ..< Int.random(in: 1 ... 4)).map(Data.init)),
        Fold(main: Object(string: "Полет МСК-СПБ #13"), data: (0 ..< Int.random(in: 1 ... 4)).map(Data.init)),
        Fold(main: Object(string: "Полет МСК-СПБ #14"), data: (0 ..< Int.random(in: 1 ... 4)).map(Data.init)),
        Fold(main: Object(string: "Полет МСК-СПБ #15"), data: (0 ..< Int.random(in: 1 ... 4)).map(Data.init)),
        Fold(main: Object(string: "Полет МСК-СПБ #16"), data: (0 ..< Int.random(in: 1 ... 4)).map(Data.init)),
        Fold(main: Object(string: "Полет МСК-СПБ #17"), data: (0 ..< Int.random(in: 1 ... 4)).map(Data.init)),
        Fold(main: Object(string: "Полет МСК-СПБ #18"), data: (0 ..< Int.random(in: 1 ... 4)).map(Data.init)),
        Fold(main: Object(string: "Полет МСК-СПБ #19"), data: (0 ..< Int.random(in: 1 ... 4)).map(Data.init)),
        Fold(main: Object(string: "Полет МСК-СПБ #20"), data: (0 ..< Int.random(in: 1 ... 4)).map(Data.init)),
        Fold(main: Object(string: "Полет МСК-СПБ #21"), data: (0 ..< Int.random(in: 1 ... 4)).map(Data.init)),
        Fold(main: Object(string: "Полет МСК-СПБ #22"), data: (0 ..< Int.random(in: 1 ... 4)).map(Data.init)),
        Fold(main: Object(string: "Полет МСК-СПБ #23"), data: (0 ..< Int.random(in: 1 ... 4)).map(Data.init)),
        Fold(main: Object(string: "Полет МСК-СПБ #24"), data: (0 ..< Int.random(in: 1 ... 4)).map(Data.init)),
        Fold(main: Object(string: "Полет МСК-СПБ #25"), data: (0 ..< Int.random(in: 1 ... 4)).map(Data.init)),
    ]

    func sections() -> [TableSection] {
        return sections(for: data)
    }

    private func sections(for data: [Fold]) -> [TableSection] {
        return data
            .map { fold -> TableSection in
                let main = MainFoldCellViewModel(object: fold.main)
                let detailed = fold.data.map(DetailFoldCellViewModel.init)
                return FoldTableSection(main: main, details: detailed)
            }
    }
}
