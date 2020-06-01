//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Eita Yamaguchi on 2020/06/01.
//  Copyright © 2020 Eita Yamaguchi. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    private var keyboardView: KeyboardLayoutView!
//    private lazy var keyboardView: KeyboardLayoutView = {
//
//        return UINib(nibName: "KeyboardLayoutView", bundle: nil)
//            .instantiate(withOwner: nil, options: nil)
//            .first as! KeyboardLayoutView
//    }()
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        guard let inputView = self.inputView else { return }
                
        keyboardView = UINib(nibName: "KeyboardLayoutView", bundle: nil)
            .instantiate(withOwner: nil, options: nil)
            .first as? KeyboardLayoutView
        
        inputView.addSubview(keyboardView)
        
        keyboardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          keyboardView.leftAnchor.constraint(equalTo: inputView.leftAnchor),
          keyboardView.topAnchor.constraint(equalTo: inputView.topAnchor),
          keyboardView.rightAnchor.constraint(equalTo: inputView.rightAnchor),
          keyboardView.bottomAnchor.constraint(equalTo: inputView.bottomAnchor)
        ])
    }
    
    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }

}
