//
//  ProfileView.swift
//  CatGram
//
//  Created by Евгений Борисов on 14.02.2024.
//

import UIKit

class ProfileView: UIView {

    private lazy var profileNameButton = {
        let profileNameButton = UIButton(type: .system)
        profileNameButton.setTitle("jykahey", for: .normal)
        profileNameButton.tintColor = .black
        profileNameButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        profileNameButton.translatesAutoresizingMaskIntoConstraints = false
        return profileNameButton
    }()

    private lazy var avatarImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 40
        avatarImageView.image = UIImage(named: "avatar1")
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.clipsToBounds = true
        return avatarImageView
    }()

    private lazy var postsStatistic = StatisticStackView(title: "posts", count: 0)
    private lazy var followersStatistic = StatisticStackView(title: "followers", count: 0)
    private lazy var followingStatistic = StatisticStackView(title: "following", count: 0)

    private lazy var commonStatisticStackView = {
        let commonStatisticStackView = UIStackView()
        commonStatisticStackView.addArrangedSubview(postsStatistic)
        commonStatisticStackView.addArrangedSubview(followersStatistic)
        commonStatisticStackView.addArrangedSubview(followingStatistic)
        commonStatisticStackView.axis = .horizontal
        commonStatisticStackView.distribution = .fillEqually
        commonStatisticStackView.alignment = .center
        commonStatisticStackView.translatesAutoresizingMaskIntoConstraints = false
        return commonStatisticStackView
    }()

    private lazy var editProfileButton = {
        let editProfileButton = UIButton(type: .system)
        editProfileButton.setTitle("Edit profile", for: .normal)
        editProfileButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        editProfileButton.layer.borderWidth = 1
        editProfileButton.tintColor = .black
        editProfileButton.layer.cornerRadius = 7
        editProfileButton.layer.borderColor = UIColor.systemGray4.cgColor
        editProfileButton.translatesAutoresizingMaskIntoConstraints = false
        return editProfileButton
    }()

    private lazy var profileDescriptionLabel = {
        let profileDescriptionLabel = UILabel()
        profileDescriptionLabel.text = "Cat gram\nprofile"
        profileDescriptionLabel.font = UIFont.systemFont(ofSize: 14)
        profileDescriptionLabel.textColor = .black
        profileDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        profileDescriptionLabel.numberOfLines = 0
        return profileDescriptionLabel
    }()

    private lazy var postsSegmentedButtons = {
        // swiftlint:disable force_unwrapping
        let postsSegmentedButtons = SegmentedButtonsView(
            frame: .zero,
            images: [UIImage(systemName: "squareshape.split.3x3")!, UIImage(systemName: "play.square.stack")!]
        )
        // swiftlint:enable force_unwrapping
        postsSegmentedButtons.translatesAutoresizingMaskIntoConstraints = false
        return postsSegmentedButtons
    }()

    private let collectionViewDataSource = CollectionViewDataSource()

    private lazy var postsCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        let postsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        postsCollectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
        postsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        postsCollectionView.delegate = self
        postsCollectionView.dataSource = collectionViewDataSource
        return postsCollectionView
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
extension ProfileView {

    private func setupUI() {
        backgroundColor = .white
        addSubviews()
        setupLayout()
    }

    private func addSubviews() {
        let subviews: [UIView] = [
            profileNameButton,
            avatarImageView,
            commonStatisticStackView,
            editProfileButton,
            profileDescriptionLabel,
            postsSegmentedButtons,
            postsCollectionView
        ]

        for view in subviews {
            addSubview(view)
        }
    }

    private func setupLayout() {

        let sideMargin: CGFloat = 15

        NSLayoutConstraint.activate([
            profileNameButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            profileNameButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: sideMargin)
        ])

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: profileNameButton.bottomAnchor, constant: 15),
            avatarImageView.leadingAnchor.constraint(equalTo: profileNameButton.leadingAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 80),
            avatarImageView.widthAnchor.constraint(equalToConstant: 80)
        ])

        NSLayoutConstraint.activate([
            commonStatisticStackView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
            commonStatisticStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -sideMargin),
            commonStatisticStackView.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            profileDescriptionLabel.leadingAnchor.constraint(equalTo: profileNameButton.leadingAnchor),
            profileDescriptionLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10),
            profileDescriptionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -50)
        ])

        NSLayoutConstraint.activate([
            editProfileButton.leadingAnchor.constraint(equalTo: profileNameButton.leadingAnchor),
            editProfileButton.topAnchor.constraint(equalTo: profileDescriptionLabel.bottomAnchor, constant: 10),
            editProfileButton.trailingAnchor.constraint(equalTo: commonStatisticStackView.trailingAnchor),
            editProfileButton.heightAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            postsSegmentedButtons.topAnchor.constraint(equalTo: editProfileButton.bottomAnchor, constant: 15),
            postsSegmentedButtons.leadingAnchor.constraint(equalTo: leadingAnchor),
            postsSegmentedButtons.trailingAnchor.constraint(equalTo: trailingAnchor),
            postsSegmentedButtons.heightAnchor.constraint(equalToConstant: 40)
        ])

        NSLayoutConstraint.activate([
            postsCollectionView.topAnchor.constraint(equalTo: postsSegmentedButtons.bottomAnchor, constant: 2),
            postsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            postsCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)

        ])

    }

}

extension ProfileView: UICollectionViewDelegate { }

extension ProfileView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let size = (self.bounds.size.width / 3) - 1.34
        return CGSize(width: size, height: size)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 2
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 2
    }
}
