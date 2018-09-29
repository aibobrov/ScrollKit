//
//  Registrar.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 29/09/2018.
//

import Foundation

protocol CellRegistrar {
    func register(cellType: AnyClass, forCellReuseIdentifier reuseIdentifier: String)
}
