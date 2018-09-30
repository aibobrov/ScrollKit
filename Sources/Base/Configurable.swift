//
//  Configurable.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 29/09/2018.
//

import Foundation

public protocol Configurable {
    associatedtype DataType

    func configure(with _: DataType)

    static var reuseIdentifier: String { get }
    static var estimatedHeight: CGFloat? { get }
    static var defaultHeight: CGFloat? { get }
}

public extension Configurable where Self: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }

    static var estimatedHeight: CGFloat? {
        return nil
    }

    static var defaultHeight: CGFloat? {
        return nil
    }
}

public extension Configurable where Self: UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }

    static var estimatedHeight: CGFloat? {
        return nil
    }

    static var defaultHeight: CGFloat? {
        return nil
    }
}
