//
//  Constraints.swift
//  NotesApp
//
//  Created by Luka Gujejiani on 06.11.24.
//

import UIKit

public enum ListViewControllerConstraints {
    static let notesLabelLeading: CGFloat = 24
    static let notesLabelTop: CGFloat = 60
    static let tableViewLeading: CGFloat = 24
    static let tableViewTrailing: CGFloat = -24
    static let tableViewTopOffset: CGFloat = -10
    static let addNoteButtonTrailing: CGFloat = -25
    static let addNoteButtonBottom: CGFloat = -25
    static let tableViewCellDistance: CGFloat = 16
    static let tableViewCellHeight: CGFloat = UIScreen.main.bounds.height * 0.12
}

public enum NotesCellConstraints {
    static let customBackgroundViewTop: CGFloat = 5
    static let customBackgroundViewBottom: CGFloat = -5
    static let titleLabelLeading: CGFloat = 23
    static let titleLabelTop: CGFloat = 19
    static let titleLabelBottom: CGFloat = -19
    static let titleLabelToDeleteButtonSpacing: CGFloat = -8
    static let deleteButtonTrailing: CGFloat = -7
    static let deleteButtonBottom: CGFloat = -12
    static let deleteButtonSize: CGFloat = UIScreen.main.bounds.height * 0.038
}

public enum EditorViewControllerConstraints {
    static let titleTextViewTop: CGFloat = 20
    static let titleTextViewLeading: CGFloat = 20
    static let titleTextViewTrailing: CGFloat = -20
    static let bodyTextViewTop: CGFloat = 10
    static let bodyTextViewLeading: CGFloat = 20
    static let bodyTextViewTrailing: CGFloat = -20
    static let bodyTextViewBottom: CGFloat = 20
    static let customBackButtonLeading: CGFloat = 16
    static let customBackButtonTop: CGFloat = 8
    static let customBackButtonSize: CGFloat = 48
}

public enum CustomAlertConstraints {
    static let containerViewWidthMultiplier: CGFloat = 0.9
    static let infoImageViewTop: CGFloat = 20
    static let infoImageViewHeightMultiplier: CGFloat = 0.0323
    static let messageLabelTop: CGFloat = 10
    static let messageLabelHorizontalPadding: CGFloat = 20
    static let buttonTop: CGFloat = 20
    static let buttonBottom: CGFloat = -20
    static let buttonHeight: CGFloat = 40
    static let buttonWidthMultiplier: CGFloat = 0.27
}
