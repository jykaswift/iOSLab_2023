//
//  CollectionViewDataSource.swift
//  CatGram
//
//  Created by Евгений Борисов on 22.02.2024.
//

import Foundation
import UIKit

class CollectionViewDataSource: NSObject, UICollectionViewDataSource {

    private lazy var data: [UIImage?] = {
        var data: [UIImage?] = []

        for i in 1...13 {
            data.append(UIImage(named: String(i)))
        }

        return data
    }()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PostCollectionViewCell.identifier, 
            for: indexPath
        ) as? PostCollectionViewCell

        guard let cell else { fatalError("Can not cast collection cell type")}

        cell.configureCell(with: data[indexPath.row])

        return cell
    }

}
