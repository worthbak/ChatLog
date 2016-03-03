//
//  MainViewCoordinator.swift
//  ChatLog
//
//  Created by David Baker on 3/3/16.
//  Copyright © 2016 Worth Baker. All rights reserved.
//

import UIKit

class MainViewCoordinator: NSObject, Coordinator {
  
  let navigationController: UINavigationController
  
  /// This variable can be set externally (for testing or customization); it is
  /// advised that you set it before calling `start()`.
  lazy var chatDataController: ChatDataController = ChatDataController()
  
  required init(withNavigationController navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let viewController = MainViewController()
    viewController.delegate = self
    self.navigationController.pushViewController(viewController, animated: false)
  }
  
}

// MARK: - Compatibility Extensions

// MARK: MainViewControllerDelegate
extension MainViewCoordinator: MainViewControllerDelegate {
  func provideChatsForDate(date: NSDate) -> [Chat] {
    return self.chatDataController.provideChatsForDate(date)
  }
  
  func newChatButtonTappedWithDate(date: NSDate) {
    let newChatVC = NewChatViewController(nibName: "NewChatViewController", bundle: nil)
    newChatVC.delegate = self
    self.navigationController.presentViewController(newChatVC, animated: true) {
      newChatVC.datePicker.setDate(date, animated: true)
    }
  }
}

// MARK: NewChatViewControllerDelegate
extension MainViewCoordinator: NewChatViewControllerDelegate {
  func newChatCreated(chat: Chat) {
    self.navigationController.dismissViewControllerAnimated(true, completion: nil)
    self.chatDataController.addNewChat(chat)
    if let mainVC = navigationController.viewControllers.last as? MainViewController {
      mainVC.setSelectedDate(chat.date)
    }
    
  }
  
  func cancelTapped() {
    self.navigationController.dismissViewControllerAnimated(true, completion: nil)
  }
}
