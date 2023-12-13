//
//  EditNoteViewController.swift
//  TableViewDiffable
//
//  Created by Евгений Борисов on 15.11.2023.
//

import UIKit

protocol EditNoteDelegate {
    func updateNoteData(with note: Note)
}

class EditNoteViewController: UIViewController {
    
    lazy var nameTF: UITextField = {
        let nameTF = UITextField()
        nameTF.translatesAutoresizingMaskIntoConstraints = false
        nameTF.placeholder = "Enter name"
        nameTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        nameTF.leftViewMode = .always
        nameTF.font = UIFont.systemFont(ofSize: 18)
        nameTF.backgroundColor = .white
        nameTF.layer.cornerRadius = 8
        return nameTF
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Name"
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Task description"
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()
    
    lazy var descriptionTV: UITextView = {
        let descriptionTV = UITextView()
        descriptionTV.font = UIFont.systemFont(ofSize: 18)
        descriptionTV.layer.cornerRadius = 8
        descriptionTV.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        descriptionTV.translatesAutoresizingMaskIntoConstraints = false
        return descriptionTV
    }()
    
    lazy var saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.textColor = .white
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        var configuration = UIButton.Configuration.filled()
        saveButton.configuration = configuration
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return saveButton
    }()
    
    var note: Note?
    var delegate: EditNoteDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    convenience init(note: Note) {
        self.init()
        self.note = note
        setData()
    }
    
    @objc func saveButtonTapped() {
        let newNote = createOrUpdateNote()
        delegate.updateNoteData(with: newNote)
        navigationController?.popViewController(animated: true)
    }
    
    private func setData() {
        nameTF.text = note!.name
        descriptionTV.text = note!.description
    }
    
    private func createOrUpdateNote() -> Note {
        
        let name: String
        let description: String
        if let text = nameTF.text, !text.isEmpty {
            name = nameTF.text!
        } else {
            name = "Unnamed"
        }

        if let text = descriptionTV.text, !text.isEmpty {
            description = descriptionTV.text!
        } else {
            description = "No description"
        }
        
        guard var note else {
            return Note(name: name, description: description)
        }
        
        note.name = name
        note.description = description
        
        return note
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray6
        view.addSubview(descriptionTV)
        view.addSubview(descriptionLabel)
        view.addSubview(nameLabel)
        view.addSubview(nameTF)
        view.addSubview(saveButton)
        navigationItem.title = "Node Editing"
        
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            nameTF.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            nameTF.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            nameTF.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            nameTF.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: nameTF.bottomAnchor, constant: 15),
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            descriptionTV.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15),
            descriptionTV.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionTV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            descriptionTV.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            saveButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    


}
