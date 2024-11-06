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
    static let shadowColor: CGColor = UIColor.black.cgColor
    static let shadowOffset: CGSize = CGSize(width: 0, height: 4)
    static let shadowOpacity: Float = 0.3
    static let shadowRadius: CGFloat = 6
}

public enum CustomAlertViewConstants {
    static let cornerRadius: CGFloat = 12
    static let secondaryCornerRadius: CGFloat = 6
}

public enum ListViewControllerConstants {
    static let tableViewCellDistance: CGFloat = 10
}

public enum CustomBackButtonConstants {
    static let shadowColor: CGColor = UIColor.black.cgColor
    static let shadowOffset: CGSize = CGSize(width: 0, height: 4)
    static let shadowOpacity: Float = 0.3
    static let shadowRadius: CGFloat = 6
    static let iconWeight: UIImage.SymbolWeight = .bold
}
