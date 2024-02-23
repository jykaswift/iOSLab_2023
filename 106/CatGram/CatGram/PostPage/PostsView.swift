//
//  PostsView.swift
//  CatGram
//
//  Created by Евгений Борисов on 22.02.2024.
//

import UIKit

class PostsView: UIView {

    private let dataSource = PostTableViewDataSource()
    weak var postsController: PostsControllerProtocol?

    private lazy var postsTableView: UITableView = {
        let postsTableView = UITableView()
        postsTableView.separatorStyle = .none
        postsTableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        postsTableView.translatesAutoresizingMaskIntoConstraints = false
        postsTableView.dataSource = dataSource
        postsTableView.rowHeight = UITableView.automaticDimension
        postsTableView.allowsSelection = false
        return postsTableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("PostView")
    }
}

// MARK: Setup UI

extension PostsView {
    private func setupUI() {
        backgroundColor = .white
        configureSwipeGestureRecognizer()
        addSubviews()
        setupLayout()
    }

    private func configureSwipeGestureRecognizer() {
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipedRight))
        gesture.direction = .right
        self.addGestureRecognizer(gesture)
    }

    @objc private func didSwipedRight() {
        postsController?.dismissController()
    }

    private func addSubviews() {
        let views = [
            postsTableView
        ]
        for view in views {
            addSubview(view)
        }
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            postsTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            postsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            postsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            postsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])

    }
}

// MARK: Communication with controller
extension PostsView {
    func scrollToPostAt(indexPath: IndexPath) {
        postsTableView.scrollToRow(at: indexPath, at: .middle, animated: false)
    }
}
