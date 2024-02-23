//
//  PostTableViewDataSource.swift
//  CatGram
//
//  Created by Евгений Борисов on 22.02.2024.
//

import Foundation
import UIKit

class PostTableViewDataSource: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DataManager.shared.syncGetPosts().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell
        guard let cell else { fatalError("Can not cast table view cell type") }
        let post = DataManager.shared.syncGetPosts()[indexPath.row]
        cell.setupCell(with: post)
        
        return cell
    }
    
}
