//
//  CustomAlertView.swift
//  NotesApp
//
//  Created by Luka Gujejiani on 31.10.24.
//

import UIKit

final class CustomAlertView: UIView {
    // MARK: - Properties
    private let infoImageView = UIImageView()
    private let messageLabel = UILabel()
    private let cancelButton = UIButton(type: .system)
    private let deleteButton = UIButton(type: .system)
    
    var onCancel: (() -> Void)?
    var onDelete: (() -> Void)?
    
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
        
        let container = UIView()
        container.backgroundColor = UIColor(hex: "#252525")
        container.layer.cornerRadius = 12
        container.translatesAutoresizingMaskIntoConstraints = false
        addSubview(container)
        
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .regular)
        let infoImage = UIImage(systemName: "info.circle.fill", withConfiguration: symbolConfig)
        infoImageView.image = infoImage
        infoImageView.tintColor = UIColor(hex: "#606060")
        infoImageView.contentMode = .scaleAspectFit
        infoImageView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(infoImageView)
        
        messageLabel.text = "Are you sure you want to\ndelete this note?"
        messageLabel.font = UIFont(name: "Nunito-Regular", size: 20)
        messageLabel.textColor = UIColor(hex: "#CFCFCF")
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(messageLabel)
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.backgroundColor = UIColor(hex: "#30BE71")
        cancelButton.layer.cornerRadius = 6
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.addAction(UIAction(handler: { [weak self] _ in
            self?.cancelButtonTapped()
        }), for: .touchUpInside)
        container.addSubview(cancelButton)
        
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.setTitleColor(.white, for: .normal)
        deleteButton.backgroundColor = UIColor(hex: "#FF0000")
        deleteButton.layer.cornerRadius = 6
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.addAction(UIAction(handler: { [weak self] _ in
            self?.deleteButtonTapped()
        }), for: .touchUpInside)
        container.addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: centerXAnchor),
            container.centerYAnchor.constraint(equalTo: centerYAnchor),
            container.widthAnchor.constraint(equalToConstant: 330),
            
            infoImageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            infoImageView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            infoImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.0323),
            
            messageLabel.topAnchor.constraint(equalTo: infoImageView.bottomAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            
            cancelButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            cancelButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            cancelButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20),
            cancelButton.heightAnchor.constraint(equalToConstant: 40),
            cancelButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.27),
            
            deleteButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            deleteButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            deleteButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20),
            deleteButton.heightAnchor.constraint(equalToConstant: 40),
            deleteButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.27)
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
