//
//  CustomKeyboardToolbar.swift
//  NotesApp
//
//  Created by Luka Gujejiani on 01.11.24.
//

import UIKit

extension UITextView {
    func addDoneButtonToolbar(onDone: (target: Any, action: Selector)? = nil) {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        toolbar.barStyle = .default
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: onDone?.target, action: onDone?.action ?? #selector(dismissKeyboard))
        
        toolbar.items = [flexibleSpace, doneButton]
        toolbar.sizeToFit()
        
        self.inputAccessoryView = toolbar
    }
    
    @objc private func dismissKeyboard() {
        self.resignFirstResponder()
    }
}
