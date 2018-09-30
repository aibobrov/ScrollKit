//
//  Message.swift
//  Example
//
//  Created by Artem Bobrov on 30/09/2018.
//

import Foundation

struct Message {
    let text: String
    let date: Date
    let isIncoming: Bool
}

extension Message {
    init(date: String, text: String, isIncoming: Bool = true) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/mm/yyyy"
        self.init(text: text, date: formatter.date(from: date) ?? Date(), isIncoming: isIncoming)
    }
}
