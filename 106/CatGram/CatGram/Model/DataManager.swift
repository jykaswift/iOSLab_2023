//
//  DataManager.swift
//  CatGram
//
//  Created by Евгений Борисов on 22.02.2024.
//

import Foundation
import UIKit

class DataManager: DataManagerProtocol {

    static let shared = DataManager()
    // swiftlint:disable force_unwrapping
    // swiftlint:disable line_length
    private var data: [Post] = [
        Post(owner: User(nickname: "jykahey", avatar: UIImage(named: "avatar1")), city: "Vladikavkaz", image: UIImage(named: "1")!, date: Date(), comments: []),
        Post(owner: User(nickname: "jykahey", avatar: UIImage(named: "avatar1")), city: "Vladikavkaz", image: UIImage(named: "2")!, date: Date(), comments: []),
        Post(owner: User(nickname: "jykahey", avatar: UIImage(named: "avatar1")), city: "Vladikavkaz", image: UIImage(named: "3")!, date: Date(), comments: []),
        Post(owner: User(nickname: "jykahey", avatar: UIImage(named: "avatar1")), city: "Vladikavkaz", image: UIImage(named: "4")!, date: Date(), comments: []),
        Post(owner: User(nickname: "jykahey", avatar: UIImage(named: "avatar1")), city: "Vladikavkaz", image: UIImage(named: "5")!, date: Date(), comments: []),
        Post(owner: User(nickname: "jykahey", avatar: UIImage(named: "avatar1")), city: "Vladikavkaz", image: UIImage(named: "6")!, date: Date(), comments: []),
        Post(owner: User(nickname: "jykahey", avatar: UIImage(named: "avatar1")), city: "Vladikavkaz", image: UIImage(named: "7")!, date: Date(), comments: []),
        Post(owner: User(nickname: "jykahey", avatar: UIImage(named: "avatar1")), city: "Vladikavkaz", image: UIImage(named: "8")!, date: Date(), comments: []),
        Post(owner: User(nickname: "jykahey", avatar: UIImage(named: "avatar1")), city: "Vladikavkaz", image: UIImage(named: "9")!, date: Date(), comments: [])
    ]
    // swiftlint:enable force_unwrapping
    // swiftlint:enable line_length
    let mutex = NSLock()

    func syncGetPosts() -> [Post] {
        return data
    }

    func asyncGetPost(completion: @escaping ([Post]) -> Void) {
        let dispatchQueue = DispatchQueue(label: "Something", attributes: .concurrent)
        var posts: [Post] = []
        let task = DispatchWorkItem {
            posts = self.syncGetPosts()
        }
        dispatchQueue.async(execute: task)

        task.notify(queue: .main) {
            completion(posts)
        }

    }
}
