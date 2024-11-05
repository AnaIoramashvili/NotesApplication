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
        image.image = UIImage(named: AlertConstants.Image.infoImage)
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .myBackground
        view.layer.cornerRadius = AlertConstants.Layout.containerCornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = AlertConstants.Text.title
        label.numberOfLines = 2
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: AlertConstants.Style.titleFontSize, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = AlertConstants.Layout.stackSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle(AlertConstants.Text.cancelButton, for: .normal)
        button.backgroundColor = .myGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = AlertConstants.Layout.buttonCornerRadius
        return button
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle(AlertConstants.Text.deleteButton, for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = AlertConstants.Layout.buttonCornerRadius
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
    private func setUpHierarchy() {
        addSubviews(containerView)
        containerView.addSubviews(infoImage, titleLabel, buttonStackView)
        buttonStackView.addArrangedSubviews(cancelButton, deleteButton)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: AlertConstants.Layout.containerWidth),
            containerView.heightAnchor.constraint(equalToConstant: AlertConstants.Layout.containerHeight),
            
            infoImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: AlertConstants.Layout.Padding.top),
            infoImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: AlertConstants.Layout.Padding.standard),
            infoImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -AlertConstants.Layout.Padding.standard),
            infoImage.heightAnchor.constraint(equalToConstant: AlertConstants.Layout.Padding.imageSize),
            infoImage.widthAnchor.constraint(equalToConstant: AlertConstants.Layout.Padding.imageSize),
            
            titleLabel.topAnchor.constraint(equalTo: infoImage.topAnchor, constant: AlertConstants.Layout.Padding.top),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: AlertConstants.Layout.Padding.standard),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -AlertConstants.Layout.Padding.standard),
            
            buttonStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: AlertConstants.Layout.Padding.top),
            buttonStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: AlertConstants.Layout.Padding.standard),
            buttonStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -AlertConstants.Layout.Padding.standard),
            buttonStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -AlertConstants.Layout.Padding.standard),
            
            cancelButton.heightAnchor.constraint(equalToConstant: AlertConstants.Layout.buttonHeight),
            deleteButton.heightAnchor.constraint(equalToConstant: AlertConstants.Layout.buttonHeight)
        ])
    }
    
    private func setupUI() {
        backgroundColor = UIColor.black.withAlphaComponent(AlertConstants.Style.backgroundAlpha)
        setUpHierarchy()
        setUpConstraints()
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

// MARK: - Extensions
extension UIStackView {
    func addArrangedSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            addArrangedSubview(subview)
        }
    }
}

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            addSubview(subview)
        }
    }
}
