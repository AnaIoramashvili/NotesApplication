//
//  NoteTableViewCell.swift
//  NoteApp
//
//  Created by Ana Ioramashvili on 31.10.24.
//

import UIKit

protocol NoteTableViewCellDelegate: AnyObject {
    func didTapDeleteButton(in cell: NoteTableViewCell)
}

final class NoteTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "NoteCell"
    weak var delegate: NoteTableViewCellDelegate?

    // MARK: - UI Elements
    private let noteView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.myCell
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = .zero
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30)
        let image = UIImage(systemName: "trash.circle.fill", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .myBackground
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - UI Setup
    private func setUpHierarchy() {
        contentView.addSubview(noteView)
        noteView.addSubview(titleLabel)
        noteView.addSubview(deleteButton)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            noteView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            noteView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            noteView.widthAnchor.constraint(equalToConstant: 365),
            noteView.heightAnchor.constraint(equalToConstant: 110),
            noteView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            titleLabel.topAnchor.constraint(equalTo: noteView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: noteView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -12),
            titleLabel.bottomAnchor.constraint(equalTo: noteView.bottomAnchor, constant: -12),
            
            deleteButton.centerYAnchor.constraint(equalTo: noteView.centerYAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: noteView.trailingAnchor, constant: -20),
            deleteButton.widthAnchor.constraint(equalToConstant: 34),
            deleteButton.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
    
    private func setupUI() {
        setUpHierarchy()
        setUpConstraints()
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    // MARK: - Configuration
    func configure(with note: Note) {
        titleLabel.text = note.title
    }
    // MARK: - Delete Button Action
    @objc private func deleteButtonTapped() {
        delegate?.didTapDeleteButton(in: self)
    }
    
    func setupDeleteButton() {
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
}
