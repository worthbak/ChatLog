//
//  NewChatViewController.swift
//  ChatLog
//
//  Created by David Baker on 3/3/16.
//  Copyright © 2016 Worth Baker. All rights reserved.
//

import UIKit

protocol NewChatViewControllerDelegate: class {
  func newChatCreated(chat: Chat)
  func cancelTapped()
}

class NewChatViewController: UIViewController {
  
  weak var delegate: NewChatViewControllerDelegate?
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var datePicker: UIDatePicker!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = .whiteColor()
    
  }
  
  override func viewDidAppear(animated: Bool) {
//    self.delegate?.cancelTapped()
  }
  
  @IBAction func doneTapped(sender: AnyObject) {
//    self.delegate?.cancelTapped()
    let newChat = Chat(withTitle: self.titleTextField.text ?? "New Chat", withDate: self.datePicker.date)

    self.delegate?.newChatCreated(newChat)
  }
  
}

extension NewChatViewController: UITextFieldDelegate {
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}