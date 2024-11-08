//
//  CustomAddButton.swift
//  NotesApp
//
//  Created by Luka Gujejiani on 31.10.24.
//

import UIKit

final class RoundedIconButton: UIButton {
    // MARK: - Initializers
    init(
        iconName: String,
        pointSize: CGFloat = RoundedButtonConstants.defaultPointSize,
        backgroundColor: UIColor = RoundedButtonConstants.defaultBackgroundColor,
        tintColor: UIColor = RoundedButtonConstants.defaultTintColor,
        cornerRadius: CGFloat = RoundedButtonConstants.defaultCornerRadius,
        size: CGFloat = RoundedButtonConstants.defaultSize
    ) {
        super.init(frame: .zero)
        initialize(iconName: iconName, pointSize: pointSize, backgroundColor: backgroundColor, tintColor: tintColor, cornerRadius: cornerRadius, size: size)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Functions
    private func initialize(
        iconName: String,
        pointSize: CGFloat,
        backgroundColor: UIColor,
        tintColor: UIColor,
        cornerRadius: CGFloat,
        size: CGFloat
    ) {
        configureUI(
            iconName: iconName,
            pointSize: pointSize,
            backgroundColor: backgroundColor,
            tintColor: tintColor,
            cornerRadius: cornerRadius
        )
        setupConstraints(size: size)
    }
    
    private func configureUI(
        iconName: String,
        pointSize: CGFloat,
        backgroundColor: UIColor,
        tintColor: UIColor,
        cornerRadius: CGFloat
    ) {
        let iconConfig = UIImage.SymbolConfiguration(pointSize: pointSize, weight: .bold)
        let iconImage = UIImage(systemName: iconName, withConfiguration: iconConfig)
        
        setImage(iconImage, for: .normal)
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        
        layer.shadowColor = RoundedButtonConstants.shadowColor
        layer.shadowOffset = RoundedButtonConstants.shadowOffset
        layer.shadowOpacity = RoundedButtonConstants.shadowOpacity
        layer.shadowRadius = RoundedButtonConstants.shadowRadius
    }
    
    private func setupConstraints(size: CGFloat) {
        widthAnchor.constraint(equalToConstant: size).isActive = true
        heightAnchor.constraint(equalToConstant: size).isActive = true
    }
}
