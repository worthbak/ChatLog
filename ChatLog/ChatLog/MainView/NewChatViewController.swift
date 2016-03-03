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
  
  @IBAction func doneTapped(sender: AnyObject) {
    let newChat = Chat(withTitle: self.titleTextField.text ?? "New Chat", withDate: self.datePicker.date)

    self.delegate?.newChatCreated(newChat)
  }
  @IBAction func cancelTapped(sender: AnyObject) {
    self.delegate?.cancelTapped()
  }
  
}

extension NewChatViewController: UITextFieldDelegate {
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}