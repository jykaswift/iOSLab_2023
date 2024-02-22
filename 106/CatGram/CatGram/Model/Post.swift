//
//  Post.swift
//  CatGram
//
//  Created by Евгений Борисов on 22.02.2024.
//

import Foundation
import UIKit
struct Post {

    let id = UUID()
    let owner: User
    let city: String
    let image: UIImage
    let date: Date
    let comments: [Comment]
}
