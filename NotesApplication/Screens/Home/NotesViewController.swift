//
//  NotesViewController.swift
//  NoteApp
//
//  Created by Ana Ioramashvili on 31.10.24.
//

import UIKit

final class NotesViewController: UIViewController, CustomAlertViewDelegate, NoteTableViewCellDelegate {
    
    // MARK: - Properties
    private var notes: [Note] = []
    private let viewModel = NotesViewModel()
    
    // MARK: - UI Elements
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(NoteTableViewCell.self, forCellReuseIdentifier: NoteTableViewCell.identifier)
        table.dataSource = self
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        let config = UIImage.SymbolConfiguration(pointSize: 24)
        let image = UIImage(systemName: "plus", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 28
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 1.0
        button.layer.shadowOffset = CGSize(width: 1, height: 2)
        button.layer.shadowRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setNavigationTitle()
        tableView.reloadData()
        DataComunication.shared.delegate = self
    }
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .myBackground
        view.addSubview(tableView)
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            addButton.widthAnchor.constraint(equalToConstant: 56),
            addButton.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    func setNavigationTitle() {
        navigationItem.title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    // MARK: - Custom Alert
    private func showDeleteAlert(for indexPath: IndexPath) {
        let alertView = CustomAlertView()
        alertView.delegate = self
        alertView.frame = view.bounds
        alertView.tag = indexPath.row
        view.addSubview(alertView)
    }
    
    // MARK: - CustomAlertViewDelegate Methods
    func didTapDeleteButton(in cell: NoteTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        showDeleteAlert(for: indexPath)
    }
    
    func didTapDeleteButton() {
        guard let alertView = view.subviews.first(where: { $0 is CustomAlertView }),
              let index = alertView.tag as Int? else { return }
        
        viewModel.deleteNote(at: index)
        tableView.reloadData()
        alertView.removeFromSuperview()
    }
    
    func didTapCancelButton() {
        guard let alertView = view.subviews.first(where: { $0 is CustomAlertView }) else { return }
        alertView.removeFromSuperview()
    }
}

// MARK: - NotesViewModelDelegate
extension NotesViewController: NotesViewModelDelegate {
    func notesDidUpdate() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - TableView DataSource
extension NotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfNotes()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.identifier, for: indexPath) as? NoteTableViewCell else {
            return UITableViewCell()
        }
        
        let note = viewModel.note(at: indexPath.row)
        cell.configure(with: note)
        cell.delegate = self
        cell.setupDeleteButton()
        
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        return cell
    }
}
// MARK: - UITableViewDelegate
extension NotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = viewModel.note(at: indexPath.row)
        let editorVC = NotesEditorViewController(note: note, index: indexPath.row)
        editorVC.delegate = self
        navigationController?.pushViewController(editorVC, animated: true)
    }
}

// MARK: - Note Editor Delegate
extension NotesViewController: NotesEditorDelegate {
    @objc private func addButtonTapped() {
        let editorVC = NotesEditorViewController()
        editorVC.delegate = self
        let navController = UINavigationController(rootViewController: editorVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    func didSaveNote(note: Note) {
        viewModel.addNote(title: note.title, content: note.content)
        tableView.reloadData()
    }
    
    func didUpdateNote(note: Note, at index: Int) {
        viewModel.updateNote(at: index, title: note.title, content: note.content)
        tableView.reloadData()

    }
}

// MARK: - DataComunicationDelegate
extension NotesViewController: DataComunicationDelegate {
    func reloadData() {
        viewModel.fetchNotes()
    }
}
