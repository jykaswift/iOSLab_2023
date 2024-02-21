import Foundation
import UIKit

protocol SegmentedControlDelegate: AnyObject {
    func didIndexChanged(at index: Int)
}

class SegmentedButtonsView: UIView {

    // MARK: - properties

    lazy var selectorView = UIView()
    lazy var imageViews: [UIImageView] = []
    private var images: [UIImage] = []
    var textColor = UIColor.lightGray
    var selectorTextColor = UIColor.black
    public private(set) var selectedIndex: Int = 0

    convenience init(frame: CGRect, images: [UIImage]) {
        self.init(frame: frame)
        self.images = images
    }

    weak var segmentedControlDelegate: SegmentedControlDelegate?
    // MARK: - config selected Tap

    private func configSelectedTap() {
        let segmentsCount = CGFloat(images.count)
        let selectorWidth = self.frame.width / segmentsCount
        selectorView = UIView(frame: CGRect(x: 0, y: self.frame.height - 0.8, width: selectorWidth, height: 0.5))
        selectorView.backgroundColor = .black
        addSubview(selectorView)
    }
    // MARK: - updateView

    private func updateView() {
        createLabels()
        configSelectedTap()
        configStackView()
    }

    // MARK: - draw

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
    }

    // MARK: - create labels

    private func createLabels() {
        imageViews.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        for image in images {

            let imageView = UIImageView()
            imageView.contentMode = .center
            let tapGestureRecognizor = UITapGestureRecognizer(target: self, action: #selector(labelActionHandler(sender:)))
            tapGestureRecognizor.numberOfTapsRequired = 1
            imageView.addGestureRecognizer(tapGestureRecognizor)
            imageView.tintColor = .lightGray
            imageView.isUserInteractionEnabled = true
            imageView.image = image.applyingSymbolConfiguration(.init(scale: .large))
            imageViews.append(imageView)

        }

        imageViews[0].tintColor = .black

    }

    // MARK: - set labels titles

    func setLabelsTitles(images: [UIImage]) {
        self.images = images
        self.updateView()
    }

    // MARK: - config stackView

    private func configStackView() {
        let stackView = UIStackView(arrangedSubviews: imageViews)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true

    }

    // MARK: - handler

    @objc private func labelActionHandler(sender: UITapGestureRecognizer) {
        for (imageIndex, image) in imageViews.enumerated() where image == sender.view {
            let selectorPosition = frame.width / CGFloat(images.count) * CGFloat(imageIndex)
            UIView.animate(withDuration: 0.1) {
                self.selectorView.frame.origin.x = selectorPosition
                self.imageViews[self.selectedIndex].tintColor = .lightGray
                self.imageViews[imageIndex].tintColor = .black
            }
            selectedIndex = imageIndex
            segmentedControlDelegate?.didIndexChanged(at: selectedIndex)

        }
    }
}
