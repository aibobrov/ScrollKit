//
//  CollectionDirector+Delegate.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 29/09/2018.
//

import Foundation

extension CollectionActionKey {
    public static let didSelectItem = CollectionActionKey("CollectionViewDidSelected")
    public static let didDeselectItem = CollectionActionKey("CollectionViewDidDeselected")
    public static let didHighlightItem = CollectionActionKey("CollectionViewDidHightlight")
    public static let didUnhighlightItem = CollectionActionKey("CollectionViewDidUnhightlight")
    public static let willDisplayCell = CollectionActionKey("CollectionViewWillDisplayCell")
    public static let didEndDisplayingCell = CollectionActionKey("CollectionViewDidendDisplayingCell")
    public static let move = CollectionActionKey("CollectionViewMove")
    public static let shouldDeselectItem = CollectionActionKey("CollectionViewShouldDeselectItem")
    public static let shouldSelectItem = CollectionActionKey("CollectionViewShouldSelectItem")

    public static let canFocusItem = CollectionActionKey("CollectionViewCanFocusItem")
    public static let shouldHighlightItem = CollectionActionKey("CollectionViewShouldHighlightItem")
    public static let shouldShowMenuForItem = CollectionActionKey("CollectionViewShouldShowMenuForItem")
    public static let willDisplaySupplementaryView = CollectionActionKey("CollectionViewWillDisplaySupplementaryView")
    public static let didEndDisplayingSupplementaryView = CollectionActionKey("CollectionViewDidEndDisplayingSupplementaryView")
    public static let sizeForItem = CollectionActionKey("CollectionViewSizeForItem")
}

extension CollectionViewUserInfoKeys {
    public static let CollectionViewProposedIndexPath = CollectionViewUserInfoKeys("CollectionViewProposedIndexPath")
    public static let CollectionViewReusableView = CollectionViewUserInfoKeys("CollectionViewReusableView")
}

extension CollectionDirector: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        self[indexPath].invoke(action: .didEndDisplayingSupplementaryView, cell: collectionView.cellForItem(at: indexPath), indexPath: indexPath, userInfo: [CollectionViewUserInfoKeys.CollectionViewSupplementaryElementKind: elementKind, CollectionViewUserInfoKeys.CollectionViewReusableView: view])
    }

    public func collectionView(_ collectionView: UICollectionView, targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath, toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
        return self[originalIndexPath].invoke(action: .move, cell: collectionView.cellForItem(at: originalIndexPath), indexPath: originalIndexPath, userInfo: [CollectionViewUserInfoKeys.CollectionViewProposedIndexPath: proposedIndexPath]) as! IndexPath? ?? proposedIndexPath
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        self[indexPath].invoke(action: .willDisplaySupplementaryView, cell: collectionView.cellForItem(at: indexPath), indexPath: indexPath, userInfo: [CollectionViewUserInfoKeys.CollectionViewSupplementaryElementKind: elementKind, CollectionViewUserInfoKeys.CollectionViewReusableView: view])
    }

    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self[indexPath].invoke(action: .didEndDisplayingCell, cell: cell, indexPath: indexPath, userInfo: nil)
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self[indexPath].invoke(action: .willDisplayCell, cell: cell, indexPath: indexPath, userInfo: nil)
    }

    public func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return self[indexPath].invoke(action: .shouldShowMenuForItem, cell: collectionView.cellForItem(at: indexPath), indexPath: indexPath, userInfo: nil) as! Bool? ?? true
    }

    public func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return self[indexPath].invoke(action: .shouldHighlightItem, cell: collectionView.cellForItem(at: indexPath), indexPath: indexPath, userInfo: nil) as! Bool? ?? true
    }

    public func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return self[indexPath].invoke(action: .shouldDeselectItem, cell: collectionView.cellForItem(at: indexPath), indexPath: indexPath, userInfo: nil) as! Bool? ?? true
    }

    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return self[indexPath].invoke(action: .shouldSelectItem, cell: collectionView.cellForItem(at: indexPath), indexPath: indexPath, userInfo: nil) as! Bool? ?? true
    }

    public func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return self[indexPath].invoke(action: .canFocusItem, cell: collectionView.cellForItem(at: indexPath), indexPath: indexPath, userInfo: nil) as! Bool? ?? true
    }

    public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        self[indexPath].invoke(action: .didUnhighlightItem, cell: collectionView.cellForItem(at: indexPath), indexPath: indexPath, userInfo: nil)
    }

    public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        self[indexPath].invoke(action: .didHighlightItem, cell: collectionView.cellForItem(at: indexPath), indexPath: indexPath, userInfo: nil)
    }

    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self[indexPath].invoke(action: .didDeselectItem, cell: collectionView.cellForItem(at: indexPath), indexPath: indexPath, userInfo: nil)
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self[indexPath].invoke(action: .didSelectItem, cell: collectionView.cellForItem(at: indexPath), indexPath: indexPath, userInfo: nil)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self[indexPath].invoke(action: .sizeForItem, cell: nil, indexPath: indexPath, userInfo: nil) as! CGSize? ?? (collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize ?? .zero
    }
}
