//
//  ViewController.swift
//  CatGram
//
//  Created by Евгений Борисов on 13.02.2024.
//

import UIKit

protocol ProfileControllerProtocol: AnyObject {
    func didSelectPostAt(indexPath: IndexPath)
}

class ProfileController: UIViewController {

    private lazy var profileView = ProfileView()

    override func loadView() {
        profileView.profileController = self
        view = profileView
    }

}

extension ProfileController: ProfileControllerProtocol {
    func didSelectPostAt(indexPath: IndexPath) {
        let postController = PostViewController()
        postController.modalPresentationStyle = .fullScreen
        postController.modalTransitionStyle = .crossDissolve
        postController.startIndexPath = indexPath
        present(postController, animated: true)
    }

}
