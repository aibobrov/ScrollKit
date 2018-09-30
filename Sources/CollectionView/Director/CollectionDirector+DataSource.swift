//
//  CollectionDirector+DataSource.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 29/09/2018.
//

import Foundation

public extension CollectionActionKey {
    public static let canMove = CollectionActionKey("CollectionViewCanMoveItem")
    public static let moveItem = CollectionActionKey("CollectionViewMoveItem")
    public static let viewForSupplementaryElement = CollectionActionKey("CollectionViewViewForSupplementaryElement")
}

public extension CollectionViewUserInfoKeys {
    public static let CollectionViewMoveDestinationIndexPath = CollectionViewUserInfoKeys("CollectionViewMoveDestinationIndexPath")
    public static let CollectionViewSupplementaryElementKind = CollectionViewUserInfoKeys("CollectionViewSupplementaryElementKind")
}

extension CollectionDirector: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].count
    }

    public func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return self[indexPath].invoke(action: .canMove, cell: collectionView.cellForItem(at: indexPath), indexPath: indexPath, userInfo: nil) as! Bool? ?? true
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        registrar?.register(cellType: self[indexPath].cellType, forCellReuseIdentifier: self[indexPath].reuseIdentifier)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self[indexPath].reuseIdentifier, for: indexPath)
        self[indexPath].configure(cell)
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        self[sourceIndexPath].invoke(action: .moveItem, cell: collectionView.cellForItem(at: sourceIndexPath), indexPath: sourceIndexPath, userInfo: [CollectionViewUserInfoKeys.CollectionViewMoveDestinationIndexPath: destinationIndexPath])
    }

    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return self[indexPath].invoke(action: .viewForSupplementaryElement, cell: collectionView.cellForItem(at: indexPath), indexPath: indexPath, userInfo: [CollectionViewUserInfoKeys.CollectionViewSupplementaryElementKind: kind]) as! UICollectionReusableView? ?? UICollectionReusableView()
    }

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
}
