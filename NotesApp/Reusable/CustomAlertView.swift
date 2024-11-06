//
//  CustomAlertView.swift
//  NotesApp
//
//  Created by Luka Gujejiani on 31.10.24.
//

import UIKit

final class CustomAlertView: UIView {
    // MARK: - Properties
    var onCancel: (() -> Void)?
    var onDelete: (() -> Void)?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#252525")
        view.layer.cornerRadius = CustomAlertViewConstants.cornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var infoImageView: UIImageView = {
        let imageView = UIImageView()
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .regular)
        imageView.image = UIImage(systemName: "info.circle.fill", withConfiguration: symbolConfig)
        imageView.tintColor = UIColor(hex: "#606060")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = CustomAlertViewTexts.messageLabelText
        label.font = UIFont(name: "Nunito-Regular", size: 20)
        label.textColor = UIColor(hex: "#CFCFCF")
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: "#30BE71")
        button.layer.cornerRadius = CustomAlertViewConstants.secondaryCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.cancelButtonTapped()
        }), for: .touchUpInside)
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: "#FF0000")
        button.layer.cornerRadius = CustomAlertViewConstants.secondaryCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.deleteButtonTapped()
        }), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    private func setupView() {
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(containerView)
        containerView.addSubview(infoImageView)
        containerView.addSubview(messageLabel)
        containerView.addSubview(cancelButton)
        containerView.addSubview(deleteButton)
        
        setupHierarchy()
    }
    
    private func setupHierarchy() {
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * CustomAlertConstraints.containerViewWidthMultiplier),
            
            infoImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: CustomAlertConstraints.infoImageViewTop),
            infoImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            infoImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * CustomAlertConstraints.infoImageViewHeightMultiplier),
            
            messageLabel.topAnchor.constraint(equalTo: infoImageView.bottomAnchor, constant: CustomAlertConstraints.messageLabelTop),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: CustomAlertConstraints.messageLabelHorizontalPadding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -CustomAlertConstraints.messageLabelHorizontalPadding),
            
            cancelButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: CustomAlertConstraints.buttonTop),
            cancelButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: CustomAlertConstraints.messageLabelHorizontalPadding),
            cancelButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: CustomAlertConstraints.buttonBottom),
            cancelButton.heightAnchor.constraint(equalToConstant: CustomAlertConstraints.buttonHeight),
            cancelButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * CustomAlertConstraints.buttonWidthMultiplier),
            
            deleteButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: CustomAlertConstraints.buttonTop),
            deleteButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -CustomAlertConstraints.messageLabelHorizontalPadding),
            deleteButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: CustomAlertConstraints.buttonBottom),
            deleteButton.heightAnchor.constraint(equalToConstant: CustomAlertConstraints.buttonHeight),
            deleteButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * CustomAlertConstraints.buttonWidthMultiplier)
        ])
    }
    
    // MARK: - Button Actions
    private func cancelButtonTapped() {
        onCancel?()
        removeFromSuperview()
    }
    
    private func deleteButtonTapped() {
        onDelete?()
        removeFromSuperview()
    }
}
