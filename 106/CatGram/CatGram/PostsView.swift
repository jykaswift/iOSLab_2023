//
//  PostsView.swift
//  CatGram
//
//  Created by Евгений Борисов on 22.02.2024.
//

import UIKit

class PostsView: UIView {

    private let dataSource = PostTableViewDataSource()

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
}

// MARK: Setup UI

extension PostsView {
    private func setupUI() {
        backgroundColor = .white
        addSubviews()
        setupLayout()
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
