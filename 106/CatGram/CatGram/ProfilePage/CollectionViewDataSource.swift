//
//  CollectionViewDataSource.swift
//  CatGram
//
//  Created by Евгений Борисов on 22.02.2024.
//

import Foundation
import UIKit

class CollectionViewDataSource: NSObject, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        DataManager.shared.syncGetPosts().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PostCollectionViewCell.identifier, 
            for: indexPath
        ) as? PostCollectionViewCell

        guard let cell else { fatalError("Can not cast collection cell type")}

        DataManager.shared.asyncGetPost { posts in
            let post = posts[indexPath.row]
            cell.configureCell(with: post.image)
        }

        return cell
    }

}
