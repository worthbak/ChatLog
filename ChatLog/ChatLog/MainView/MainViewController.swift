//
//  MainViewController.swift
//  ChatLog
//
//  Created by David Baker on 3/3/16.
//  Copyright © 2016 Worth Baker. All rights reserved.
//

import UIKit

let CalendarViewHeight: CGFloat = 80

class MainViewController: UIViewController {
  
  private lazy var calendarViewController: CalendarViewController = {
    let dateVC = CalendarViewController()
    dateVC.view.translatesAutoresizingMaskIntoConstraints = false
    self.addChildViewController(dateVC)
    self.view.addSubview(dateVC.view)
    dateVC.didMoveToParentViewController(self)
    
    return dateVC
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = .orangeColor()
    
    // add constraints for the child view controllers
    MainViewController.createConstraintsForCalendarViewController(self.calendarViewController, withParentViewController: self)
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
}
