//
//  MainViewController.swift
//  ChatLog
//
//  Created by David Baker on 3/3/16.
//  Copyright © 2016 Worth Baker. All rights reserved.
//

import UIKit

// Constants
let CalendarViewHeight: CGFloat = 80
let PlusButtonDimension: CGFloat = 60

class MainViewController: UIViewController {
  
  private lazy var calendarViewController: CalendarViewController = {
    let dateVC = CalendarViewController()
    dateVC.view.translatesAutoresizingMaskIntoConstraints = false
    self.addChildViewController(dateVC)
    self.view.addSubview(dateVC.view)
    dateVC.didMoveToParentViewController(self)
    
    return dateVC
  }()
  
  private lazy var chatTableViewController: ChatTableViewController = {
    let chatVC = ChatTableViewController()
    chatVC.view.translatesAutoresizingMaskIntoConstraints = false
    self.addChildViewController(chatVC)
    self.view.addSubview(chatVC.view)
    chatVC.didMoveToParentViewController(self)
    
    return chatVC
  }()
  
  private lazy var plusButton: PlusButton = {
    let button = PlusButton(type: .System)
    button.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(button)
    
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = "ChatLog"
    
    // Set navBar appearance
    self.navigationController?.navigationBar.barTintColor = CLBlue
    self.navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
    self.navigationController?.navigationBar.titleTextAttributes = [
      NSForegroundColorAttributeName : CLWhite,
      NSFontAttributeName : UIFont.systemFontOfSize(20)
    ]
    
    // add constraints for the child view controllers
    MainViewController.createConstraintsForCalendarViewController(self.calendarViewController, withParentViewController: self)
    MainViewController.createConstraintsForChatTableViewController(self.chatTableViewController, withParentViewController: self, withTopAnchor: self.calendarViewController.bottomLayoutGuide.bottomAnchor)
    
    // add the plus button constraints
    MainViewController.createConstraintsForPlusButton(self.plusButton, withParentViewController: self)
  }
  
}

// Static, standalone functions for adding view constraints
extension MainViewController {
  
  static func createConstraintsForCalendarViewController(calendarVC: CalendarViewController, withParentViewController parentVC: UIViewController, withCalendarHeight height: CGFloat = CalendarViewHeight) {
    calendarVC.view.topAnchor.constraintEqualToAnchor(parentVC.topLayoutGuide.bottomAnchor).active = true
    calendarVC.view.leadingAnchor.constraintEqualToAnchor(parentVC.view.leadingAnchor).active = true
    calendarVC.view.trailingAnchor.constraintEqualToAnchor(parentVC.view.trailingAnchor).active = true
    calendarVC.view.heightAnchor.constraintEqualToConstant(height).active = true
  }
  
  static func createConstraintsForChatTableViewController(chatVC: ChatTableViewController, withParentViewController parentVC: UIViewController, withTopAnchor topAnchor: NSLayoutAnchor) {
    chatVC.view.topAnchor.constraintEqualToAnchor(topAnchor).active = true
    chatVC.view.leadingAnchor.constraintEqualToAnchor(parentVC.view.leadingAnchor).active = true
    chatVC.view.trailingAnchor.constraintEqualToAnchor(parentVC.view.trailingAnchor).active = true
    chatVC.view.bottomAnchor.constraintEqualToAnchor(parentVC.bottomLayoutGuide.bottomAnchor).active = true
  }
  
  static func createConstraintsForPlusButton(plusButton: PlusButton, withParentViewController parentVC: UIViewController, withButtonDimension dimension: CGFloat = PlusButtonDimension) {
    plusButton.heightAnchor.constraintEqualToConstant(dimension).active = true
    plusButton.widthAnchor.constraintEqualToConstant(dimension).active = true
    plusButton.centerXAnchor.constraintEqualToAnchor(parentVC.view.centerXAnchor).active = true
    plusButton.bottomAnchor.constraintEqualToAnchor(parentVC.bottomLayoutGuide.bottomAnchor, constant: -8.0).active = true
  }
}
