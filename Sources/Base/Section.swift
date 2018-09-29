//
//  Section.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 29/09/2018.
//

import Foundation

protocol Section {
    associatedtype ItemType: Item

    var items: [ItemType] { get }
}
