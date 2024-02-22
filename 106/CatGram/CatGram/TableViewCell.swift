//
//  TableViewCell.swift
//  CatGram
//
//  Created by Евгений Борисов on 22.02.2024.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    static let identifier = "Post"

    private lazy var avatarImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 16
        avatarImageView.image = UIImage(named: "questionmark")
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.clipsToBounds = true
        return avatarImageView
    }()

    private lazy var nicknameLabel: UILabel = {
        let nicknameLabel = UILabel()
        nicknameLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        nicknameLabel.text = "city"
        nicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nicknameLabel
    }()

    private lazy var cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.font = UIFont.systemFont(ofSize: 12)
        cityLabel.text = "city"
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        return cityLabel
    }()

    private lazy var postImageView: UIImageView = {
        let postImageView = UIImageView()
        postImageView.contentMode = .scaleToFill
        postImageView.image = UIImage(named: "questionmark")
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        postImageView.clipsToBounds = true
        return postImageView
    }()

    private lazy var likeButton: UIButton = {
        let likeButton = UIButton(type: .system)
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = .black
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        
        return likeButton
    }()

    func setupCell(with post: Post) {
        avatarImageView.image = post.owner.avatar
        postImageView.image = post.image
        nicknameLabel.text = post.owner.nickname
        cityLabel.text = post.city
        setupUI()
    }
    
    private func setupUI() {
        addSubviews()
        setupLayout()
    }

    private func addSubviews() {
        let views = [
            avatarImageView,
            nicknameLabel,
            cityLabel,
            postImageView,
            likeButton
        ]

        for view in views {
            contentView.addSubview(view)
        }
    }

    private func setupLayout() {
        let margin: CGFloat = 10

        contentView.layer.borderColor = UIColor.red.cgColor
        contentView.layer.borderWidth = 1
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin),
            avatarImageView.heightAnchor.constraint(equalToConstant: 32),
            avatarImageView.widthAnchor.constraint(equalToConstant: 32)
        ])

        NSLayoutConstraint.activate([
            nicknameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: margin),
            nicknameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: nicknameLabel.leadingAnchor),
            cityLabel.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: 2)
        ])

        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: margin),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: margin),
            likeButton.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

    }

}
