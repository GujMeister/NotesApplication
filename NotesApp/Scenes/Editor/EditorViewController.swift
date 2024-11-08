//
//  EditorViewController.swift
//  NotesApp
//
//  Created by Luka Gujejiani on 01.11.24.
//

import UIKit

protocol AddNoteDelegate: AnyObject {
    func didAddNote()
}

final class EditorViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: EditorViewModel
    weak var delegate: AddNoteDelegate?

    // MARK: - Components
    private lazy var customBackButton: UIButton = {
        let button = CustomBackButton(
            iconName: "chevron.left",
            pointSize: 20,
            backgroundColor: .darkGray,
            tintColor: .white,
            cornerRadius: 14,
            size: 48
        )
        
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.backButtonTapped()
        }), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var titleTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.delegate = self
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    private lazy var bodyTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.delegate = self
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    // MARK: - Lifecycle
    init(viewModel: EditorViewModel) {
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
        viewModel.loadData()
        saveEmptyNoteIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#252525")
        
        titleTextView.addDoneButtonToolbar()
        bodyTextView.addDoneButtonToolbar(onDone: (target: self, action: #selector(customDoneAction)))

        setupHierarchy()
        setupConstraints()
    }
    
    private func setupHierarchy() {
        view.addSubview(titleTextView)
        view.addSubview(bodyTextView)
        view.addSubview(customBackButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleTextView.topAnchor.constraint(equalTo: customBackButton.bottomAnchor, constant: EditorViewControllerConstraints.titleTextViewTop),
            titleTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: EditorViewControllerConstraints.titleTextViewLeading),
            titleTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: EditorViewControllerConstraints.titleTextViewTrailing),
            
            bodyTextView.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: EditorViewControllerConstraints.bodyTextViewTop),
            bodyTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: EditorViewControllerConstraints.bodyTextViewLeading),
            bodyTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: EditorViewControllerConstraints.bodyTextViewTrailing),
            bodyTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: EditorViewControllerConstraints.bodyTextViewBottom),
            
            customBackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: EditorViewControllerConstraints.customBackButtonLeading),
            customBackButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: EditorViewControllerConstraints.customBackButtonTop),
            customBackButton.widthAnchor.constraint(equalToConstant: EditorViewControllerConstraints.customBackButtonSize),
            customBackButton.heightAnchor.constraint(equalToConstant: EditorViewControllerConstraints.customBackButtonSize)
        ])
    }
    
    //MARK: - ViewModel Binding
    private func setupBindings() {
        viewModel.onTitleUpdate = { [weak self] title in
            guard let self = self else { return }
            if let title = title, !title.isEmpty {
                self.titleTextView.text = title
                self.titleTextView.textColor = .white
            } else {
                self.titleTextView.text = "Title"
                self.titleTextView.textColor = UIColor.lightGray
            }
        }
        
        viewModel.onBodyUpdate = { [weak self] body in
            guard let self = self else { return }
            if let body = body, !body.isEmpty {
                self.bodyTextView.text = body
                self.bodyTextView.textColor = .white
            } else {
                self.bodyTextView.text = "Type something..."
                self.bodyTextView.textColor = UIColor.lightGray
            }
        }
    }
    
    // MARK: - Actions
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func customDoneAction() {
        view.endEditing(true)
    }
}

// MARK: - Text View Delegate
extension EditorViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = .white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            if textView == titleTextView {
                textView.text = "Title"
                textView.textColor = UIColor.lightGray
            } else if textView == bodyTextView {
                textView.text = "Type something..."
                textView.textColor = UIColor.lightGray
            }
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        autoSaveNote()
    }
    
    // Methods
    private func saveEmptyNoteIfNeeded() {
        if viewModel.isNewNote {
            viewModel.saveNote(title: "", body: "")
        }
        delegate?.didAddNote()
    }
    
    private func autoSaveNote() {
        var titleText = titleTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        var bodyText = bodyTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        if titleTextView.textColor == UIColor.lightGray {
            titleText = ""
        }
        
        if bodyTextView.textColor == UIColor.lightGray {
            bodyText = ""
        }

        viewModel.saveNote(title: titleText, body: bodyText)
        delegate?.didAddNote()
    }
}

