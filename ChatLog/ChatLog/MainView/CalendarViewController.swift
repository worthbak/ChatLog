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
  func dateTapped(date: NSDate)
}

class CalendarViewController: UIViewController {
  
  weak var delegate: CalendarViewControllerDelegate?
  
  var selectedDate = NSDate()
  
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
  }
  
  func constructDates() {
    for view in self.dateStackView.arrangedSubviews {
      self.dateStackView.removeArrangedSubview(view)
    }
    
    for x in 0..<7 {
      let view = UIView()
      view.tag = x
      view.translatesAutoresizingMaskIntoConstraints = false
      
      // construct the date
      let currentDate = self.constructDateWithOffsetFromCurrentDate(x)
      
      if NSCalendar.currentCalendar().isDate(currentDate, inSameDayAsDate: self.selectedDate) {
        view.backgroundColor = CLLightBlue
      } else {
        view.backgroundColor = CLWhite
      }
      
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(label)
      
      if let chats = self.delegate?.provideChatsForDate(currentDate) {
        label.text = "\(chats.count)"
      }
      
      label.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
      label.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
      self.dateStackView.addArrangedSubview(view)
      
      view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "dateTapped:"))
    }
  }
  
  func dateTapped(sender: UITapGestureRecognizer) {
    guard let tappedView = sender.view else { return }
    
    // construct the date
    let offset = tappedView.tag
    self.selectedDate = self.constructDateWithOffsetFromCurrentDate(offset)
    
    self.delegate?.dateTapped(self.selectedDate)
  }
  
  private func constructDateWithOffsetFromCurrentDate(offset: Int) -> NSDate {
    let components: NSDateComponents = NSDateComponents()
    components.setValue(offset, forComponent: NSCalendarUnit.Day);
    let date: NSDate = NSDate()
    if let expirationDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: date, options: NSCalendarOptions(rawValue: 0)) {
      return expirationDate
    } else {
      fatalError("failed to construct date for comparison")
    }
  }
  
}
