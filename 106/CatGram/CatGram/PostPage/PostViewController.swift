//
//  PostViewController.swift
//  CatGram
//
//  Created by Евгений Борисов on 22.02.2024.
//

import UIKit

protocol PostsControllerProtocol: AnyObject {
    func dismissController()
    func showDeleteAlert(with postId: UUID)
}

protocol PostControllerDelegate: AnyObject {
    func reloadCollectionData()
}

class PostViewController: UIViewController {
    private lazy var postsView = PostsView()
    var startIndexPath: IndexPath?
    weak var delegate: PostControllerDelegate?

    override func loadView() {
        postsView.postsController = self
        view = postsView
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let startIndexPath else { return }
        postsView.scrollToPostAt(indexPath: startIndexPath)
    }

    deinit {
        print("PostViewController")
    }
}

extension PostViewController {
    private func deletePost(with postId: UUID) {
        DataManager.shared.asyncDeletePost(with: postId) { [weak self] in
            self?.postsView.reloadData()
            self?.delegate?.reloadCollectionData()
        }

    }
}

extension PostViewController: PostsControllerProtocol {
    func showDeleteAlert(with postId: UUID) {
        let alertController = UIAlertController(title: "Deleting post", message: "Do you want delete this post?", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
            self?.deletePost(with: postId)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true)
    }
    
    func dismissController() {
        dismiss(animated: true)
    }
}
