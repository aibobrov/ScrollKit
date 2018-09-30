//
//  ViewController.swift
//  Example
//
//  Copyright © 2018. All rights reserved.
//

import ScrollKit
import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    private let messages: [Message] = [
        Message(date: "01/02/2014", text: "Hello, how are you?", isIncoming: false),
        Message(date: "03/05/2016", text: "I'm fine, thanks. It's my another long message. It should appear on the right side."),
        Message(date: "03/05/2016", text: "What are you doing tonight? Wanna do out?", isIncoming: false),
        Message(date: "03/05/2016", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis ", isIncoming: false),
        Message(date: "03/05/2016", text: "When exploring a new dataset we have various tools in our analysis and visualization toolkit. These tools include things like averages and summary statistics, line charts and histograms, as well as an ever expanding catalog of custom visualizations."),
        Message(date: "29/03/2018", text: "When the Google Creative Lab built Quick, Draw!, they had the foresight to save anonymized copies of the drawings, altering the course of my life forever. At this point millions of people across the globe have played and Google has open sourced 50 million of the drawings they created. This means we have on average more than 100,000 drawings for each of the 300 words in the game to explore."),
        Message(date: "29/03/2018", text: "Just because something is difficult, doesn’t mean it can’t be done. Since the dataset was released several amazing projects applied various techniques to surface interesting patterns in the data.", isIncoming: false),
    ]

    private var _tableDirector: TableDirector!

    override func loadView() {
        super.loadView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        _tableDirector = TableDirector(tableView: tableView, shouldUseAutomaticCellRegistration: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

		let action = TableItemAction<MessageTableViewCell>(.tapped) { [unowned self] options in
			let alert = UIAlertController(title: "Action", message: "Tapped on \(options.indexPath)", preferredStyle: .alert)
			self.present(alert, animated: true, completion: {
				DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(1), execute: {
					alert.dismiss(animated: true, completion: nil)
				})
			})
		}
        let sections: [TableSection] = {
            let data = Dictionary(grouping: messages, by: { $0.date })
            let messagesSection = data.keys.sorted().map { data[$0]! }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            return messagesSection.map { messages -> TableSection in
				let section = TableSection(items: messages.map { TableItem<MessageTableViewCell>(item: $0, actions: [action]) })
                section.headerHeight = 50
                section.headerFactory = { tv, index in
                    let dateString = dateFormatter.string(from: messages.first!.date)

                    let label = DateHeaderLabel()
                    label.text = dateString

                    let containerView = UIView()

                    containerView.addSubview(label)
                    label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
                    label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true

                    return containerView
                }
                return section
            }
        }()

        _tableDirector
            .append(sections: sections)
            .reload()


    }
}
