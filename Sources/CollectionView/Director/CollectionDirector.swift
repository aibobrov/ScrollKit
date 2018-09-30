//
//  CollectionDirector.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 29/09/2018.
//

import Foundation

open class CollectionDirector: NSObject {
    public weak var collectionView: UICollectionView?

    public var sections: [CollectionSection] = []

    internal var delegate: UICollectionViewDelegate?
    internal var registrar: CellRegistrar?

    public init(collectionView: UICollectionView, shouldUseAutomaticCellRegistration: Bool = false) {
        self.collectionView = collectionView

        if shouldUseAutomaticCellRegistration {
            registrar = CollectionCellRegistrar(collectionView: collectionView)
        }

        super.init()

        collectionView.delegate = self
        collectionView.dataSource = self

        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveAction(_:)), name: .CollectionViewCellAction, object: nil)
    }

    @discardableResult
    public func reload() -> Self {
        collectionView?.reloadData()
        return self
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

public extension CollectionDirector {
    @discardableResult
    public func append(section: CollectionSection) -> Self {
        append(sections: [section])
        return self
    }

    @discardableResult
    public func append(sections: [CollectionSection]) -> Self {
        self.sections.append(contentsOf: sections)
        return self
    }

    @discardableResult
    public func append(items: [CollectionItemAbstract]) -> Self {
        append(section: CollectionSection(items: items))
        return self
    }

    @discardableResult
    public func insert(section: CollectionSection, at index: Int) -> Self {
        sections.insert(section, at: index)
        return self
    }

    @discardableResult
    public func replaceSection(at index: Int, with section: CollectionSection) -> Self {
        if index < sections.count {
            sections[index] = section
        }
        return self
    }

    @discardableResult
    public func delete(sectionAt index: Int) -> Self {
        sections.remove(at: index)
        return self
    }

    @discardableResult
    public func remove(sectionAt index: Int) -> Self {
        return delete(sectionAt: index)
    }

    @discardableResult
    public func clear() -> Self {
        sections.removeAll()
        return self
    }
}
