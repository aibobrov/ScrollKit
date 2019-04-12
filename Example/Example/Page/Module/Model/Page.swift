enum Page {
    case content(data: [Data])
    case last(data: [Data])
    case empty

    var data: [Data] {
        switch self {
        case let .content(data):
            return data
        case let .last(data):
            return data
        case .empty:
            return []
        }
    }
}
