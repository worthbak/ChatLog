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
  
  override func viewDidAppear(animated: Bool) {
    self.titleTextField.becomeFirstResponder()
  }
  
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

/*
Rules

1pt if you're not attracted to the person
2pts if you'd consider going on a date with this person
3pts if you're actively attracted to this person 
4pts if you actually ask this person out

4pts max per day
*/