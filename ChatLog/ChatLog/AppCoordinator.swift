//
//  AppCoordinator.swift
//  ChatLog
//
//  Created by David Baker on 3/3/16.
//  Copyright © 2016 Worth Baker. All rights reserved.
//

import UIKit

// Discussion of the coordinator pattern and its benefits (primarily the reduction of UIViewController 
// responsibilities) can be found here: http://khanlou.com/2015/10/coordinators-redux/
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
    let mainViewCoordinator = MainViewCoordinator(withNavigationController: self.navigationController)
//    mainViewCoordinator.delegate = self
    self.childCoordinators.append(mainViewCoordinator)
    mainViewCoordinator.start()
  }
  
}
