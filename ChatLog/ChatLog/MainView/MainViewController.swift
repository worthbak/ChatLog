//
//  MainViewController.swift
//  ChatLog
//
//  Created by David Baker on 3/3/16.
//  Copyright © 2016 Worth Baker. All rights reserved.
//

import UIKit

// MARK: - Constants / Protocols
private let CalendarViewHeight: CGFloat = 80
private let PlusButtonDimension: CGFloat = 60

protocol MainViewControllerDelegate: class {
  func provideChatsForDate(date: NSDate) -> [Chat]
  func newChatButtonTappedWithDate(date: NSDate)
}

// MARK: - MainViewController
class MainViewController: UIViewController {
  
  weak var delegate: MainViewControllerDelegate?
  
  // MARK: Lazy-loaded UI Elements
  private lazy var calendarViewController: CalendarViewController = {
    let dateVC = CalendarViewController()
    dateVC.delegate = self
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
    
    button.tapActionClosure = { [unowned self] _ in self.delegate?.newChatButtonTappedWithDate(self.calendarViewController.selectedDate) }
    
    return button
  }()
  
  // MARK: View Lifecycle
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
    
    // set up the initial displayed data
    self.reloadChatData()
  }
  
  /// Sets the currently selected date and reloads all chat data
  func setSelectedDate(date: NSDate, andReloadData reload: Bool = true) {
    self.calendarViewController.selectedDate = date
    
    if reload {
      self.reloadChatData()
    }
  }
  
  /// Reloads/resets the data in both the calendar view and chat table view.
  func reloadChatData() {
    self.calendarViewController.constructDates()
    
    let chats = self.delegate?.provideChatsForDate(self.calendarViewController.selectedDate)
    self.chatTableViewController.chatsForDisplay = chats ?? [Chat]()
    self.chatTableViewController.tableView.reloadData()
  }
}

// MARK: - CalendarViewControllerDelegate
extension MainViewController: CalendarViewControllerDelegate {
  func provideChatsForDate(date: NSDate) -> [Chat] {
    if let chats = self.delegate?.provideChatsForDate(date) {
      return chats
    } else {
      fatalError("there is no delegate for the main view controller; this is not allowed")
    }
  }
  
  func dateTapped(date: NSDate) {
    self.reloadChatData()
  }
}

// MARK: - Layout Generation
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
