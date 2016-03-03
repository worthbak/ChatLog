//
//  DateViewController.swift
//  ChatLog
//
//  Created by David Baker on 3/3/16.
//  Copyright © 2016 Worth Baker. All rights reserved.
//

import UIKit

protocol CalendarViewControllerDelegate: class {
  func provideChatsForDate(date: NSDate) -> [Chat]
}

class CalendarViewController: UIViewController {
  
  weak var delegate: CalendarViewControllerDelegate?
  
  private lazy var dateStackView: UIStackView = {
    let stackView = UIStackView(frame: CGRectZero)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.distribution = .FillEqually
    stackView.spacing = 1.0
    self.view.addSubview(stackView)
    
    return stackView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .whiteColor()
    
    // Do any additional setup after loading the view.
    self.dateStackView.topAnchor.constraintEqualToAnchor(self.view.topAnchor).active = true
    self.dateStackView.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor).active = true
    self.dateStackView.trailingAnchor.constraintEqualToAnchor(self.view.trailingAnchor).active = true
    self.dateStackView.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor).active = true
    
    for x in 0..<7 {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      if x == 1 {
        view.backgroundColor = CLLightBlue
      } else {
        view.backgroundColor = CLWhite
      }
      
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(label)
      
      // construct the date
      let components: NSDateComponents = NSDateComponents()
      components.setValue(x, forComponent: NSCalendarUnit.Day);
      let date: NSDate = NSDate()
      let expirationDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: date, options: NSCalendarOptions(rawValue: 0))
      
      if let date = expirationDate, let chats = self.delegate?.provideChatsForDate(date) {
        label.text = "\(chats.count)"
      }
      
      label.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
      label.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
      self.dateStackView.addArrangedSubview(view)
    }
  }
  
}
