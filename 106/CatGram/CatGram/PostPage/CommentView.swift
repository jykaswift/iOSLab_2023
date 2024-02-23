//
//  CommentView.swift
//  CatGram
//
//  Created by Евгений Борисов on 23.02.2024.
//

import Foundation

//
//  CommentView.swift
//  CatGram
//
//  Created by Евгений Борисов on 23.02.2024.
//

import UIKit

class CommentView: UIStackView {

    private lazy var userButton: UIButton = {
        let userButton = UIButton(type: .system)
        userButton.setTitle("User", for: .normal)
        userButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        userButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        userButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        userButton.tintColor = .black

        let action = UIAction { _ in
            print("1")

        }

        userButton.addAction(action, for: .touchUpInside)
        return userButton
    }()

    private lazy var message: UILabel = {
        let message = UILabel()
        message.text = "Comment"
        message.font = UIFont.systemFont(ofSize: 12)
        return message
    }()

    convenience init(comment: Comment) {
        self.init(frame: .zero)
        setupComment(with: comment)
        setupUI()
    }

    func setupComment(with comment: Comment) {
        userButton.setTitle(comment.user.nickname, for: .normal)
        message.text = comment.message
        setupUI()
    }

    private func setupUI() {
        addArrangedSubview(userButton)
        addArrangedSubview(message)
        spacing = 5
    }
}
