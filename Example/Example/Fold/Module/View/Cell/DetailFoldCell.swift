//
//  DetailFoldCell.swift
//  Example
//
//  Created by Artem Bobrov on 12/04/2019.
//

import UIKit

class DetailFoldCell: UITableViewCell {
    let label: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        backgroundColor = .lightGray
        addSubview(label)
        selectionStyle = .none
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds.insetBy(dx: 16, dy: 0)
    }
}
