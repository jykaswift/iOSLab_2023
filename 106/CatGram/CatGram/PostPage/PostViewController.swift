//
//  PostViewController.swift
//  CatGram
//
//  Created by Евгений Борисов on 22.02.2024.
//

import UIKit

protocol PostsControllerProtocol: AnyObject {
    func dismissController()
}

class PostViewController: UIViewController {
    private lazy var postsView = PostsView()
    var startIndexPath: IndexPath?

    override func loadView() {
        postsView.postsController = self
        view = postsView
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let startIndexPath else { return }
        postsView.scrollToPostAt(indexPath: startIndexPath)
    }
    
    deinit {
        print("PostViewController")
    }
}

extension PostViewController: PostsControllerProtocol {
    func dismissController() {
        dismiss(animated: true)
    }
}
