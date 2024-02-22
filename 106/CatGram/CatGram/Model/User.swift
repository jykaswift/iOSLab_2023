//
//  User.swift
//  CatGram
//
//  Created by Евгений Борисов on 22.02.2024.
//

import Foundation
import UIKit

class User {
    let nickname: String
    var avatar: UIImage?

    init(nickname: String, avatar: UIImage? = nil) {
        self.nickname = nickname
        self.avatar = avatar
    }
}
