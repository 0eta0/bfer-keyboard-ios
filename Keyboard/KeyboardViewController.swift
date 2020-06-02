//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Eita Yamaguchi on 2020/06/01.
//  Copyright © 2020 Eita Yamaguchi. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    // MARK: IBOutlet

    @IBOutlet var nextKeyboardButton: UIButton!

    // MARK: View

    private var keyboardView: KeyboardLayoutView!
    
    // MARK: Properties

    var timer: Timer?
    
    // MARK: Override

    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard",
                                                           comment: "Title for 'Next Keyboard' button"),
                                         for: [])
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
        
        /// [
        self.keyboardView.button1.addTarget(self, action: #selector(button1Handler), for: .touchUpInside)
        /// +
        self.keyboardView.button2.addTarget(self, action: #selector(button2Handler), for: .touchUpInside)
        /// -
        self.keyboardView.button3.addTarget(self, action: #selector(button3Handler), for: .touchUpInside)
        /// ]
        self.keyboardView.button4.addTarget(self, action: #selector(button4Handler), for: .touchUpInside)
        /// <
        self.keyboardView.button5.addTarget(self, action: #selector(button5Handler), for: .touchUpInside)
        /// .
        self.keyboardView.button6.addTarget(self, action: #selector(button6Handler), for: .touchUpInside)
        /// ,
        self.keyboardView.button7.addTarget(self, action: #selector(button7Handler), for: .touchUpInside)
        /// >
        self.keyboardView.button8.addTarget(self, action: #selector(button8Handler), for: .touchUpInside)
        
        let LTGesture = UILongPressGestureRecognizer(target: self, action: #selector(longDeleteHandler(gesture:)))
        /// long delete
        self.keyboardView.delete.addGestureRecognizer(LTGesture)
        /// delete
        self.keyboardView.delete.addTarget(self, action: #selector(deleteHandler), for: [.touchDown])
    }
    
    @objc func button1Handler() {
        
        let proxy = self.textDocumentProxy
        proxy.insertText("[")
    }
    
    @objc func button2Handler() {

        let proxy = self.textDocumentProxy
        proxy.insertText("+")
    }
    
    @objc func button3Handler() {
        
        let proxy = self.textDocumentProxy
        proxy.insertText("-")
    }

    @objc func button4Handler() {
        
        let proxy = self.textDocumentProxy
        proxy.insertText("]")
    }
    
    @objc func button5Handler() {
        
        let proxy = self.textDocumentProxy
        proxy.insertText("<")
    }
    
    @objc func button6Handler() {
        
        let proxy = self.textDocumentProxy
        proxy.insertText(".")
    }
    
    @objc func button7Handler() {
        
        let proxy = self.textDocumentProxy
        proxy.insertText(",")
    }
    
    @objc func button8Handler() {
        
        let proxy = self.textDocumentProxy
        proxy.insertText(">")
    }
    
    @objc func deleteHandler() {
        
        let proxy = self.textDocumentProxy
        proxy.deleteBackward()
    }

    @objc func longDeleteHandler(gesture: UILongPressGestureRecognizer) {

        let proxy = self.textDocumentProxy

        if gesture.state == .began {
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                proxy.deleteBackward()
            }
        }

        if gesture.state == .ended {
            timer?.invalidate()
        }
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
