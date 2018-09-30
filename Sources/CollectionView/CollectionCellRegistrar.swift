//
//  CollectionCellRegistrar.swift
//  ScrollKit
//
//  Created by Artem Bobrov on 29/09/2018.
//

import Foundation

class CollectionCellRegistrar: CellRegistrar {
    private var registeredIdentifiers: Set<String> = []
    private weak var collectionView: UICollectionView?

    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }

    func register(cellType: AnyClass, forCellReuseIdentifier reuseIdentifier: String) {
        guard !registeredIdentifiers.contains(reuseIdentifier) else { return }

        let bundle = Bundle(for: cellType)
        if let _ = bundle.path(forResource: reuseIdentifier, ofType: "nib") {
            collectionView?.register(UINib(nibName: reuseIdentifier, bundle: bundle), forCellWithReuseIdentifier: reuseIdentifier)
        } else {
            collectionView?.register(cellType, forCellWithReuseIdentifier: reuseIdentifier)
        }

        registeredIdentifiers.insert(reuseIdentifier)
    }
}
