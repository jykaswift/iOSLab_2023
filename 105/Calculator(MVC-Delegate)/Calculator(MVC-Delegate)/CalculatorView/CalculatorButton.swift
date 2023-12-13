//
//  CalculatorButton.swift
//  Calculator(MVC-Delegate)
//
//  Created by Евгений Борисов on 17.11.2023.
//

import UIKit

class CalculatorButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? color.lighter(by: 20) : color
        }
    }
    
    var operation: Operation?
    
    static var buttonSize: CGFloat = 75
    let color: UIColor
    init(color: UIColor, text: String, operation: Operation? = nil) {
        self.operation = operation
        self.color = color
        super.init(frame: .zero)
        setupButton(with: color, and: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton(with color: UIColor, and text: String) {
    
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(text, for: .normal)
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        backgroundColor = color
        layer.cornerRadius = CalculatorButton.buttonSize * 0.5
        setupSize()
    }
    
    private func setupSize() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: CalculatorButton.buttonSize),
            self.widthAnchor.constraint(equalToConstant: CalculatorButton.buttonSize),
        ])
    }
    
}

extension UIColor {

    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }

    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }

    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
}
