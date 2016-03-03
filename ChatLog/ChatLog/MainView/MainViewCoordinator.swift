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
  
  required init(withNavigationController navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let viewController = MainViewController()
//    viewController.delegate = self
    self.navigationController.pushViewController(viewController, animated: false)
  }
  
}
