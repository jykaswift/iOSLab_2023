//
//  StatisticStackView.swift
//  CatGram
//
//  Created by Евгений Борисов on 14.02.2024.
//

import UIKit

class StatisticStackView: UIStackView {

    var title = "" {
        didSet {
            statisticTitleLabel.text = title
        }
    }

    var count = 0 {
        didSet {
            statisticCountLabel.text = String(count)
        }
    }

    private lazy var statisticTitleLabel = {
        let statisticTitleLabel = UILabel()
        statisticTitleLabel.text = title
        statisticTitleLabel.font = UIFont.systemFont(ofSize: 14)
        statisticTitleLabel.textColor = .black
        return statisticTitleLabel
    }()

    private lazy var statisticCountLabel = {
        let statisticCountLabel = UILabel()
        statisticCountLabel.text = String(count)
        statisticCountLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        statisticCountLabel.textColor = .black
        return statisticCountLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
    }

    convenience init(title: String, count: Int) {
        self.init()
        self.title = title
        self.count = count
        statisticCountLabel.text = String(count)
        statisticTitleLabel.text = title
    }

    private func setupStackView() {
        addArrangedSubview(statisticCountLabel)
        addArrangedSubview(statisticTitleLabel)
        axis = .vertical
        distribution = .fillEqually
        spacing = 5
        alignment = .center
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
