public struct TableDiff: Difference {
    public static var identity: TableDiff {
        return TableDiff(deleted: nil, inserted: nil, reloaded: nil)
    }

    public let deleted: [Int]?
    public let inserted: [Int]?
    public let reloaded: [Int]?

    public init(deleted: [Int]? = nil,
                inserted: [Int]? = nil,
                reloaded: [Int]? = nil) {
        self.deleted = deleted
        self.inserted = inserted
        self.reloaded = reloaded
    }

    public func combined(with diff: Difference) -> TableDiff {
        return TableDiff(deleted: (deleted ?? []) + (diff.deleted ?? []),
                         inserted: (inserted ?? []) + (diff.inserted ?? []),
                         reloaded: (reloaded ?? []) + (diff.reloaded ?? []))
    }
}
