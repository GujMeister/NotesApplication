//
//  ListViewController.swift
//  NotesApp
//
//  Created by Luka Gujejiani on 31.10.24.
//

import UIKit

final class ListViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: ListViewModel
    
    private let notesLabel: UILabel = {
        let label = UILabel()
        label.text = ListViewControllerTexts.noteText
        label.font = UIFont(name: "Nunito-SemiBold", size: 43)
        label.textColor = .white
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(NotesCellTableViewCell.self, forCellReuseIdentifier: NotesCellTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private lazy var addNoteButton: RoundedIconButton = {
        let button = RoundedIconButton(
            iconName: ListViewControllerConstants.addNoteButtonIconName,
            pointSize: ListViewControllerConstants.addNoteButtonPointSize,
            backgroundColor: ListViewControllerConstants.addNoteButtonBackground,
            tintColor: ListViewControllerConstants.addNoteButtonTintColor,
            cornerRadius: ListViewControllerConstants.addNoteButtonCornerRadius,
            size: ListViewControllerConstants.addNoteButtonSize
        )
        
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.pushAddNoteViewController()
        }), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycle
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#252525")
        
        let views = [notesLabel, tableView, addNoteButton]
        
        views.forEach { subview in
            view.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        
        setupHierarchy()
    }
    
    private func setupHierarchy() {
        NSLayoutConstraint.activate([
            notesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ListViewControllerConstraints.notesLabelLeading),
            notesLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: ListViewControllerConstraints.notesLabelTop),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ListViewControllerConstraints.tableViewLeading),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ListViewControllerConstraints.tableViewTrailing),
            tableView.topAnchor.constraint(equalTo: notesLabel.bottomAnchor, constant: ListViewControllerConstraints.tableViewTopOffset),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            addNoteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ListViewControllerConstraints.addNoteButtonTrailing),
            addNoteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: ListViewControllerConstraints.addNoteButtonBottom)
        ])
    }
    
    // MARK: - Bindings
    private func setupBindings() {
        viewModel.onNotesUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Button Actions
    private func pushAddNoteViewController() {
        let editorViewModel = EditorViewModel(note: nil)
        let editorVC = EditorViewController(viewModel: editorViewModel)
        editorVC.delegate = self
        self.navigationController?.pushViewController(editorVC, animated: true)
    }
}

// MARK: - Table View
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.noteCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotesCellTableViewCell.reuseIdentifier, for: indexPath) as! NotesCellTableViewCell
        let note = viewModel.note(at: indexPath.row)
        cell.configure(with: note)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return ListViewControllerConstraints.tableViewCellDistance
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = viewModel.coreNote(at: indexPath.row)
        let editorVM = EditorViewModel(note: note)
        let editorVC = EditorViewController(viewModel: editorVM)
        editorVC.delegate = self
        navigationController?.pushViewController(editorVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ListViewControllerConstraints.tableViewCellHeight
    }
}

//MARK: Add Note Delegate
extension ListViewController: AddNoteDelegate {
    func didAddNote() {
        viewModel.fetchNotes()
        tableView.reloadData()
    }
}

// MARK: Delete Note Delegate
extension ListViewController: NotesCellTableViewCellDelegate {
    func didTapDeleteButton(on cell: NotesCellTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        let customAlert = CustomAlertView()
        customAlert.onCancel = { [weak self] in
            self?.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        customAlert.onDelete = { [weak self] in
            self?.viewModel.deleteNote(at: indexPath.row)
        }
        
        customAlert.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customAlert)
        
        setupConstraints(for: customAlert, on: view)
    }
    
    private func setupConstraints(for view: UIView, on containerView: UIView) {
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            view.topAnchor.constraint(equalTo: containerView.topAnchor),
            view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}
