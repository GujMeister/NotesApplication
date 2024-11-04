//
//  NotesCellTableViewCell.swift
//  NotesApp
//
//  Created by Luka Gujejiani on 31.10.24.
//

import UIKit

protocol NotesCellTableViewCellDelegate: AnyObject {
    func didTapDeleteButton(on cell: NotesCellTableViewCell)
}

final class NotesCellTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let reuseIdentifier = "NotesCellTableViewCell"
    weak var delegate: NotesCellTableViewCellDelegate?
    
    lazy var customBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.backgroundColor = UIColor(hex: "#FFF599")
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Nunito-Regular", size: 22)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        let iconConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .bold)
        let trashIcon = UIImage(systemName: "trash.fill", withConfiguration: iconConfig)
        button.setImage(trashIcon, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(customBackgroundView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(deleteButton)
        setupConstraints()
    }
    
    // MARK: - UI Setup
    private func setupConstraints() {
        customBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            customBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            customBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            customBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            customBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 23),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 19),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -19),
            titleLabel.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -8),
            
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7),
            deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            deleteButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.038),
            deleteButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.038)
        ])
    }
    
    func configure(with note: Note) {
        titleLabel.text = note.title
    }
    
    @objc private func deleteButtonTapped() {
        delegate?.didTapDeleteButton(on: self)
    }
}
