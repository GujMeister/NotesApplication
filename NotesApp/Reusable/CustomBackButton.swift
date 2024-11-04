//
//  CustomBackButton.swift
//  NotesApp
//
//  Created by Luka Gujejiani on 31.10.24.
//

import UIKit

final class CustomBackButton: UIButton {
    // MARK: - Initializers
    init(iconName: String = "chevron.left", pointSize: CGFloat = 20, backgroundColor: UIColor = .darkGray, tintColor: UIColor = .white, cornerRadius: CGFloat = 14, size: CGFloat = 48) {
        super.init(frame: .zero)
        
        setupButton(iconName: iconName, pointSize: pointSize, backgroundColor: backgroundColor, tintColor: tintColor, cornerRadius: cornerRadius, size: size)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupButton(iconName: String, pointSize: CGFloat, backgroundColor: UIColor, tintColor: UIColor, cornerRadius: CGFloat, size: CGFloat) {
        let iconConfig = UIImage.SymbolConfiguration(pointSize: pointSize, weight: .bold)
        let iconImage = UIImage(systemName: iconName, withConfiguration: iconConfig)
        
        setImage(iconImage, for: .normal)
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        layer.cornerRadius = cornerRadius
        clipsToBounds = false

        widthAnchor.constraint(equalToConstant: size).isActive = true
        heightAnchor.constraint(equalToConstant: size).isActive = true

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 6
    }
}
