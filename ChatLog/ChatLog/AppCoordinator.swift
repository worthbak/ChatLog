//
//  AppCoordinator.swift
//  ChatLog
//
//  Created by David Baker on 3/3/16.
//  Copyright © 2016 Worth Baker. All rights reserved.
//

import UIKit

protocol Coordinator {
  init(withNavigationController navigationController: UINavigationController)
  func start()
}

class AppCoordinator: NSObject, Coordinator {
  
  let navigationController: UINavigationController
  var childCoordinators = [Coordinator]()
  
  required init(withNavigationController navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    
  }
  
}
