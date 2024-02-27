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
    private lazy var user = User(nickname: "jykahey", avatar: UIImage(named: "avatar1"))
    // swiftlint:disable force_unwrapping

    private lazy var data: [Post] = [
        Post(
            owner: user,
            city: "Vladikavkaz", image: UIImage(named: "1")!,
            date: Date.now,
            comments: [
                Comment(user: user, message: "cute cat"),
                Comment(user: User(nickname: "catenjoyer", avatar: UIImage(named: "6")), message: "cute cat")
            ]
        ),
        Post(
            owner: user,
            city: "Moskow", image: UIImage(named: "2")!,
            date: Date.now,
            comments: [
                Comment(user: user, message: "Caaaaaat")
            ]
        ),
        Post(
            owner: user,
            city: "Saint-Petersburg", image: UIImage(named: "3")!,
            date: Date.now,
            comments: []
        ),
        Post(
            owner: user,
            city: "Vladikavkaz", image: UIImage(named: "4")!,
            date: Date.now,
            comments: []
        )

    ]
    // swiftlint:enable force_unwrapping

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

    func syncDeletePost(with postId: UUID) {
        data.removeAll { post in
            post.id == postId
        }
    }

    func asyncDeletePost(with postId: UUID, completion: @escaping () -> Void) {
        let dispatchQueue = DispatchQueue(label: "Something", attributes: .concurrent)

        let task = DispatchWorkItem {
            self.syncDeletePost(with: postId)
        }
        dispatchQueue.async(execute: task)

        task.notify(queue: .main) {
            completion()
        }
    }
}
