//
//  TableSection.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 29/09/2018.
//

import Foundation

open class TableSection: TableSectionAbstract {
    public typealias HeaderFooterFactory = (UITableView, Int) -> UIView
    public typealias HeaderFooterConfig = (UITableView, UIView, Int) -> Void

    open var indexTitle: String?

    open var headerTitle: String?
    open var footerTitle: String?

    open var headerView: UIView?
    open var footerView: UIView?

    open var headerHeight: CGFloat?
    open var footerHeight: CGFloat?

    open var estimatedHeaderHeight: CGFloat?
    open var estimatedFooterHeight: CGFloat?

    open var headerFactory: HeaderFooterFactory?
    open var footerFactory: HeaderFooterFactory?

    public init(
        items: [TableItemAbstract] = [],
        headerReuseIdentifier: String?,
        headerConfig: HeaderFooterConfig?,
        footerReuseIdentifier: String?,
        footerConfig: HeaderFooterConfig?
    ) {
        super.init(items: items)
        if let reuseID = headerReuseIdentifier {
            headerFactory = { tv, section in
                let view = tv.dequeueReusableHeaderFooterView(withIdentifier: reuseID)!
                headerConfig?(tv, view, section)
                return view
            }
        }

        if let reuseID = headerReuseIdentifier {
            footerFactory = { tv, section in
                let view = tv.dequeueReusableHeaderFooterView(withIdentifier: reuseID)!
                headerConfig?(tv, view, section)
                return view
            }
        }
    }

    public init(
        items: [TableItemAbstract] = [],
        headerView: UIView? = nil,
        headerConfig: HeaderFooterConfig? = nil,
        footerView: UIView? = nil,
        footerConfig: HeaderFooterConfig? = nil
    ) {
        super.init(items: items)

        self.headerView = headerView
        self.footerView = footerView

        if headerView != nil {
            headerFactory = { tv, section in
                headerConfig?(tv, headerView!, section)
                return headerView!
            }
        }

        if footerView != nil {
            footerFactory = { tv, section in
                headerConfig?(tv, footerView!, section)
                return footerView!
            }
        }
    }
}
