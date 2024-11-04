//
//  NotesEditorViewController.swift
//  NoteApp
//
//  Created by Ana Ioramashvili on 02.11.24.
//

import UIKit

protocol NotesEditorDelegate: AnyObject {
    func didSaveNote(note: Note)
    func didUpdateNote(note: Note, at index: Int)
}

final class NotesEditorViewController: UIViewController {
    // MARK: - Properties
    weak var delegate: NotesEditorDelegate?
    private let viewModel: NotesEditorViewModel
    private var isEditingMode: Bool = false
    
    // MARK: - UI Components
    private let titleTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 28, weight: .bold)
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.textContainer.maximumNumberOfLines = 0
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16)
        textView.backgroundColor = .clear
        textView.textColor = .white
        textView.textContainer.maximumNumberOfLines = 0
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    // MARK: - Initialization
    init(note: Note? = nil, index: Int? = nil) {
        self.viewModel = NotesEditorViewModel(note: note, index: index)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        setupDelegates()
        
        if viewModel.isEditingMode {
            titleTextView.text = viewModel.title
            contentTextView.text = viewModel.content
            titleTextView.textColor = .white
            contentTextView.textColor = .white
        } else {
            titleTextView.text = "Title"
            titleTextView.textColor = .gray
            contentTextView.text = "Type something..."
            contentTextView.textColor = .gray
        }
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .myBackground
        view.addSubview(titleTextView)
        view.addSubview(contentTextView)
        
        NSLayoutConstraint.activate([
            titleTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            contentTextView.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 20),
            contentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            contentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            contentTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        backButton.backgroundColor = UIColor(white: 0, alpha: 0.3)
        backButton.layer.cornerRadius = 15
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)

        let backButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backButtonItem
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Save",
            style: .done,
            target: self,
            action: #selector(saveButtonTapped)
        )
        navigationController?.navigationBar.tintColor = .white

        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 48),
            backButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func setupDelegates() {
        titleTextView.delegate = self
        contentTextView.delegate = self
    }
    
    private func populateData(with note: Note) {
        titleTextView.text = note.title
        contentTextView.text = note.content
        titleTextView.textColor = .white
        contentTextView.textColor = .white
    }
    
    // MARK: - Actions
    @objc private func dismissViewController() {
        if isEditingMode {
            navigationController?.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }
    
    @objc private func saveButtonTapped() {
        guard let title = titleTextView.text,
              let content = contentTextView.text,
              viewModel.isValidNote(title: title, content: content) else {
            return
        }
        
        let (note, index) = viewModel.saveNote(title: title, content: content)
        
        if viewModel.isEditingMode {
            delegate?.didUpdateNote(note: note, at: index!)
            navigationController?.popViewController(animated: true)
        } else {
            delegate?.didSaveNote(note: note)
            dismiss(animated: true)
        }
    }
}

// MARK: - UITextViewDelegate
extension NotesEditorViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == titleTextView && textView.textColor == .gray {
            textView.text = ""
            textView.textColor = .white
        } else if textView == contentTextView && textView.textColor == .gray {
            textView.text = ""
            textView.textColor = .white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == titleTextView && textView.text.isEmpty {
            textView.text = "Title"
            textView.textColor = .gray
        } else if textView == contentTextView && textView.text.isEmpty {
            textView.text = "Type something..."
            textView.textColor = .gray
        }
    }
}
