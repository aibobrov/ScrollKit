import UIKit

final class LoaderPage: UITableViewCell {
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.frame.size = CGSize(width: 30, height: 30)
        indicator.color = .black
        return indicator
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
        addSubview(activityIndicator)
        selectionStyle = .none
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicator.frame = bounds
    }

    func startAnimating() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }

    func stopAnimating() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
}
