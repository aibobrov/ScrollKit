//
//  Item.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 29/09/2018.
//

import Foundation

public protocol Item: /* Hashable, */ ItemConfigurable, Actionable {
    var reuseIdentifier: String { get }
    var cellType: AnyClass { get }

    var estimatedHeight: CGFloat? { get }
    var defaultHeight: CGFloat? { get }
}
