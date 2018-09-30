//
//  DateSectionView.swift
//  Example
//
//  Created by Artem Bobrov on 30/09/2018.
//

import UIKit

class DateHeaderLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .gray
        textColor = .white
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false // enables auto layout
        font = UIFont.boldSystemFont(ofSize: 14)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        let originalContentSize = super.intrinsicContentSize
        let height = originalContentSize.height + 12
        layer.cornerRadius = height / 2
        layer.masksToBounds = true
        return CGSize(width: originalContentSize.width + 20, height: height)
    }
}
