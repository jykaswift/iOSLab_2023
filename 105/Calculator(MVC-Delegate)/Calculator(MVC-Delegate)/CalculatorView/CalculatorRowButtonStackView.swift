//
//  CalculatorRowButtonStackView.swift
//  Calculator(MVC-Delegate)
//
//  Created by Евгений Борисов on 17.11.2023.
//

import UIKit

class CalculatorRowButtonStackView: UIStackView {

    init(buttons: [CalculatorButton]) {
        super.init(frame: .zero)
        setupStackView(with: buttons)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStackView(with buttons: [CalculatorButton]) {
        axis = .horizontal
        distribution = .equalSpacing
        for button in buttons {
            addArrangedSubview(button)
        }
    }

}
