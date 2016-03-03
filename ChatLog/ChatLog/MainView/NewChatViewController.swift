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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = .redColor()
    
    let button = UIButton(type: .System)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("done", forState: .Normal)
    self.view.addSubview(button)
    button.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
    button.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
    
    button.addTarget(self, action: "doneTapped:", forControlEvents: .TouchUpInside)
  }
  
  func doneTapped(sender: AnyObject) {
//    self.delegate?.cancelTapped()
    let newChat = Chat(withTitle: "fart")
    self.delegate?.newChatCreated(newChat)
  }
  
}
