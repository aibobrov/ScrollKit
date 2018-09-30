//
//  MessageTableViewCell.swift
//  Example
//
//  Created by Artem Bobrov on 30/09/2018.
//

import ScrollKit
import UIKit

class MessageTableViewCell: UITableViewCell, Configurable {
    let messageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    let backgroundBubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!

    func configure(with message: Message) {
        backgroundBubbleView.backgroundColor = message.isIncoming ? .white : .blue
        messageLabel.textColor = message.isIncoming ? .black : .white
        messageLabel.text = message.text
        leadingConstraint.isActive = message.isIncoming
        trailingConstraint.isActive = !message.isIncoming
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear

        addSubview(backgroundBubbleView)
        addSubview(messageLabel)
        let const: CGFloat = 16
        let constraints = [
            messageLabel.topAnchor.constraint(equalTo: backgroundBubbleView.topAnchor, constant: const),
            messageLabel.bottomAnchor.constraint(equalTo: backgroundBubbleView.bottomAnchor, constant: -const),
            messageLabel.leadingAnchor.constraint(equalTo: backgroundBubbleView.leadingAnchor, constant: const),
            messageLabel.trailingAnchor.constraint(equalTo: backgroundBubbleView.trailingAnchor, constant: -const),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),

            backgroundBubbleView.topAnchor.constraint(equalTo: topAnchor, constant: const),
            backgroundBubbleView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        ]
        NSLayoutConstraint.activate(constraints)

        leadingConstraint = backgroundBubbleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: const)
        leadingConstraint.isActive = false

        trailingConstraint = backgroundBubbleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -const)
        trailingConstraint.isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
