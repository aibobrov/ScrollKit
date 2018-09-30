//
//  Abstract.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 29/09/2018.
//

import Foundation

func abstract(message: String = "", function: String = #function, file: String = #file) -> Never {
    return fatalError("abstract method: \(function), in \(file)\n\(message)")
}
