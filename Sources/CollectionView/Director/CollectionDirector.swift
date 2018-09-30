//
//  CollectionDirector.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 29/09/2018.
//

import Foundation

open class CollectionDirector: NSObject {
    public weak var collectionView: UICollectionView? {
        didSet {
            collectionView?.delegate = self
            collectionView?.dataSource = self
        }
    }

    public var sections: [CollectionSection] = []

    internal var delegate: UICollectionViewDelegate?
    internal var registrar: CellRegistrar?

    public init(collectionView: UICollectionView, shouldUseAutomaticCellRegistration: Bool = false) {
        self.collectionView = collectionView

        if shouldUseAutomaticCellRegistration {
            registrar = CollectionCellRegistrar(collectionView: collectionView)
        }

        super.init()

        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveAction(_:)), name: .CollectionViewCellAction, object: nil)
    }

    public func reload() {
        collectionView?.reloadData()
    }

    public subscript(indexPath: IndexPath) -> CollectionItemAbstract {
        get {
            return sections[indexPath.section].items[indexPath.row]
        }
        set {
            sections[indexPath.section].items[indexPath.row] = newValue
        }
    }

    @objc func didReceiveAction(_ notification: Notification) {
        guard let action = notification.object as? CollectionCellAction, let indexPath = collectionView?.indexPath(for: action.cell) else { return }
        self[indexPath].invoke(action: action.key, cell: action.cell, indexPath: indexPath, userInfo: nil)
    }
}

extension CollectionDirector: Collection {
    public typealias Index = Array<CollectionSection>.Index
    public typealias Element = CollectionSection

    public var startIndex: Index {
        return sections.startIndex
    }

    public var endIndex: Index {
        return sections.endIndex
    }

    public func index(after i: Index) -> Index {
        return sections.index(after: i)
    }

    public subscript(position: Index) -> Element {
        get {
            return sections[position]
        }
        set {
            sections[position] = newValue
        }
    }
}
