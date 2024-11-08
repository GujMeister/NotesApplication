//
//  Constraints.swift
//  NotesApp
//
//  Created by Luka Gujejiani on 06.11.24.
//

import UIKit

// MARK: - Constants
public enum RoundedButtonConstants {
    static let defaultPointSize: CGFloat = 12
    static let defaultBackgroundColor: UIColor = .darkGray
    static let defaultTintColor: UIColor = .white
    static let defaultCornerRadius: CGFloat = 25
    static let defaultSize: CGFloat = 70
    static let shadowColor: CGColor = UIColor.white.cgColor
    static let shadowOffset: CGSize = CGSize(width: 10, height: 10)
    static let shadowOpacity: Float = 1
    static let shadowRadius: CGFloat = 40
}

public enum CustomAlertViewConstants {
    static let cornerRadius: CGFloat = 12
    static let secondaryCornerRadius: CGFloat = 6
}

public enum ListViewControllerConstants {
    static let tableViewCellDistance: CGFloat = 10
    static let addNoteButtonIconName: String = "plus"
    static let addNoteButtonPointSize: CGFloat = UIScreen.main.bounds.height * 0.03
    static let addNoteButtonBackground: UIColor = UIColor(hex: "#252525")
    static let addNoteButtonTintColor: UIColor = .white
    static let addNoteButtonCornerRadius: CGFloat = 35
    static let addNoteButtonSize: CGFloat = UIScreen.main.bounds.height * 0.08
}

public enum EditorViewControllerConstants {
    static let customBackButtonIconName: String = "chevron.left"
    static let customBackButtonPointSize: CGFloat = 20
    static let customBackButtonBackgroundColor: UIColor = .darkGray
    static let customBackButtonTintColor: UIColor = .white
    static let customBackButtonCornerRadius: CGFloat = 14
    static let customBackButtonSize: CGFloat = 48
}

public enum CustomBackButtonConstants {
    static let shadowColor: CGColor = UIColor.black.cgColor
    static let shadowOffset: CGSize = CGSize(width: 0, height: 4)
    static let shadowOpacity: Float = 0.3
    static let shadowRadius: CGFloat = 6
    static let iconWeight: UIImage.SymbolWeight = .bold
}
