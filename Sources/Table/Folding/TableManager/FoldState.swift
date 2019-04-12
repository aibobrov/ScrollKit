public enum FoldState {
    case open
    case close
    case unavailable

    public var next: FoldState {
        switch self {
        case .open:
            return .close
        case .close:
            return .open
        case .unavailable:
            return .unavailable
        }
    }
}
