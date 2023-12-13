//
//  ViewController.swift
//  TableViewDiffable
//
//  Created by Евгений Борисов on 15.11.2023.
//

import UIKit

class NotesViewController: UIViewController {
    
    enum TableSection {
        case note
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: NoteTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none

        return tableView
    }()
    
    var notes: [Note] = [Note(name: "abc", description: "fsafaf")]
    var dataSourceDiffable: UITableViewDiffableDataSource<TableSection, Note>?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        setupDataSource()
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray6
        view.addSubview(tableView)
        setupLayout()
    }
    

    private func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

}




// MARK: TableView Delegate
extension NotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notes[indexPath.row]
        let editNoteVC = EditNoteViewController(note: note)
        editNoteVC.delegate = self
        navigationController?.pushViewController(editNoteVC, animated: true)
    }
}


// MARK: Navigation Setup
extension NotesViewController {
    
    private func setupNavigationBar() {
        navigationItem.title = "Notes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    
    @objc func addButtonTapped() {
        let editVC = EditNoteViewController()
        editVC.delegate = self
        navigationController?.pushViewController(editVC, animated: true)
    }
}


// MARK: DataSource Setup

extension NotesViewController {
    private func setupDataSource() {
        dataSourceDiffable = UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, note in
            let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.reuseIdentifier, for: indexPath) as! NoteTableViewCell
            cell.setData(with: note)
            return cell
        }
        updateDataSource(with: notes)
    }
    
    private func updateDataSource(with notes: [Note]) {
        var snapshop = NSDiffableDataSourceSnapshot<TableSection, Note>()
        snapshop.appendSections([.note])
        snapshop.appendItems(notes, toSection: .note)
        dataSourceDiffable?.apply(snapshop)
    }
}

// MARK: EditNote Delegate

extension NotesViewController: EditNoteDelegate {
    func updateNoteData(with note: Note) {
        guard let index = notes.firstIndex(where: { currentNote in
            currentNote.id == note.id
        }) else {
            notes.append(note)
            updateNoteData(with: note)
            return
        }
        notes[index] = note
        updateDataSource(with: notes)
    }
}
