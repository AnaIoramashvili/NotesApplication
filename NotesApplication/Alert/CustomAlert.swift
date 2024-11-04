//
//  CustomAlert.swift
//  NoteApp
//
//  Created by Ana Ioramashvili on 01.11.24.
//

import UIKit

protocol CustomAlertViewDelegate: AnyObject {
    func didTapDeleteButton()
    func didTapCancelButton()
}

final class CustomAlertView: UIView {
    
    // MARK: - Properties
    weak var delegate: CustomAlertViewDelegate?
    
    // MARK: - UI Elements
    private let infoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Information")
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .myBackground
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Are you sure you want to delete note?"
        label.numberOfLines = 2
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.backgroundColor = .myGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        addSubview(containerView)
        containerView.addSubview(infoImage)
        containerView.addSubview(titleLabel)
        containerView.addSubview(buttonStackView)
        
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 330),
            containerView.heightAnchor.constraint(equalToConstant: 235),
            
            infoImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            infoImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            infoImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            infoImage.heightAnchor.constraint(equalToConstant: 36),
            infoImage.widthAnchor.constraint(equalToConstant: 36),

            
            titleLabel.topAnchor.constraint(equalTo: infoImage.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            buttonStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            buttonStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            buttonStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            buttonStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            
            cancelButton.heightAnchor.constraint(equalToConstant: 40),
            deleteButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - Setup Actions
    private func setupActions() {
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Button Actions
    @objc private func cancelButtonTapped() {
        delegate?.didTapCancelButton()
    }
    
    @objc private func deleteButtonTapped() {
        delegate?.didTapDeleteButton()
    }
}
