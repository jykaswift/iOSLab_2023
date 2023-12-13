//
//  NoteTableViewCell.swift
//  TableViewDiffable
//
//  Created by Евгений Борисов on 15.11.2023.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    lazy private var taskNameLabel: UILabel = {
        let taskNameLabel = UILabel()
        taskNameLabel.translatesAutoresizingMaskIntoConstraints = false
        taskNameLabel.numberOfLines = 0
        taskNameLabel.textAlignment = .center
        return taskNameLabel
    }()
    
    lazy private var taskDescriptionLabel: UILabel = {
        let taskDescriptionLabel = UILabel()
        taskDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        taskDescriptionLabel.numberOfLines = 0
        return taskDescriptionLabel
    }()
    
    lazy private var containerView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(with note: Note) {
        taskNameLabel.text = note.name
        taskDescriptionLabel.text = note.description
    }
    
    private func setupCell() {
        if taskNameLabel.superview != nil { return }
        
        contentView.backgroundColor = .systemGray6
        contentView.addSubview(containerView)
        containerView.addSubview(taskNameLabel)
        containerView.addSubview(taskDescriptionLabel)
        
        setupLayout()
    }
    
    private func setupLayout() {
        
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            taskNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            taskNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            taskNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            taskDescriptionLabel.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 10),
            taskDescriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            taskDescriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            taskDescriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}


extension NoteTableViewCell {
    static var reuseIdentifier: String {
        return String(self.description())
    }
}
