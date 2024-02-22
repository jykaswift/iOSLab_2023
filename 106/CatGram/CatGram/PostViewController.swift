//
//  PostViewController.swift
//  CatGram
//
//  Created by Евгений Борисов on 22.02.2024.
//

import UIKit

class PostViewController: UIViewController {
    private lazy var postsView = PostsView()

    override func loadView() {
        view = postsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    



}
