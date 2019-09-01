import ScrollKit

final class FoldViewModel {
	let data = (1...100).map { index in
		Fold(
			main: Object(string: "Flight \(index)"),
			data: (0 ..< Int.random(in: 1 ... 4)).map(Data.init)
		)
	}

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
