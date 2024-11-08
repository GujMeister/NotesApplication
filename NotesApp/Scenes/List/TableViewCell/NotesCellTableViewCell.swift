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
        view.layer.cornerRadius = CustomAlertViewConstants.cornerRadius
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: "#FFF599")
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Nunito-Regular", size: 22)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        let iconConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .bold)
        let trashIcon = UIImage(systemName: "trash.fill", withConfiguration: iconConfig)
        button.setImage(trashIcon, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .darkGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = CustomAlertViewConstants.cornerRadius
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
        setupCell()
    }
    
    // MARK: - UI Setup
    private func setupCell() {
        self.backgroundColor = .clear
        self.selectionStyle = .none

        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            customBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            customBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            customBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: NotesCellConstraints.customBackgroundViewTop),
            customBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: NotesCellConstraints.customBackgroundViewBottom),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: NotesCellConstraints.titleLabelLeading),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: NotesCellConstraints.titleLabelTop),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: NotesCellConstraints.titleLabelBottom),
            titleLabel.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: NotesCellConstraints.titleLabelToDeleteButtonSpacing),
            
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: NotesCellConstraints.deleteButtonTrailing),
            deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: NotesCellConstraints.deleteButtonBottom),
            deleteButton.widthAnchor.constraint(equalToConstant: NotesCellConstraints.deleteButtonSize),
            deleteButton.heightAnchor.constraint(equalToConstant: NotesCellConstraints.deleteButtonSize)
        ])
    }

    
    func configure(with note: Note) {
        titleLabel.text = note.title
    }
    
    @objc private func deleteButtonTapped() {
        delegate?.didTapDeleteButton(on: self)
    }
}
