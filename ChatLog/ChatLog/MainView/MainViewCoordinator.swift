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
  lazy var chatDataController: ChatDataController = ChatDataController() // can be injected for testing
  
  required init(withNavigationController navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    // add test chat
    let testChat = Chat(withTitle: "hello!")
    self.chatDataController.addNewChat(testChat)
    
    let viewController = MainViewController()
    viewController.delegate = self
    self.navigationController.pushViewController(viewController, animated: false)
  }
  
}

extension MainViewCoordinator: MainViewControllerDelegate {
  func provideChatsForDate(date: NSDate) -> [Chat] {
    return self.chatDataController.provideChatsForDate(date)
  }
  
  func newChatButtonTapped() {
    
    let newChatVC = NewChatViewController(nibName: "NewChatViewController", bundle: nil)
    newChatVC.delegate = self
    self.navigationController.presentViewController(newChatVC, animated: true, completion: nil)
  }
}

extension MainViewCoordinator: NewChatViewControllerDelegate {
  func newChatCreated(chat: Chat) {
    self.navigationController.dismissViewControllerAnimated(true, completion: nil)
    self.chatDataController.addNewChat(chat)
    if let mainVC = navigationController.viewControllers.last as? MainViewController {
      mainVC.reloadChatData()
    }
    
  }
  
  func cancelTapped() {
    self.navigationController.dismissViewControllerAnimated(true, completion: nil)
  }
}
