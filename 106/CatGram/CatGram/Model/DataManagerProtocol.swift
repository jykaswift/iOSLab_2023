//
//  DataManagerProtocol.swift
//  CatGram
//
//  Created by Евгений Борисов on 22.02.2024.
//

import Foundation

protocol DataManagerProtocol {
    
    func syncGetPosts() -> [Post]
    func asyncGetPost(completion: @escaping ([Post]) -> Void) 

    func syncDeletePost(with postId: UUID)
    func asyncDeletePost(with postId: UUID, completion: @escaping () -> Void)

}
