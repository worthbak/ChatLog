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
  
  // MARK: Instance Variables
  weak var delegate: CalendarViewControllerDelegate?
  
  /// Represents the currently selected date; setting this value has no side effects.
  var selectedDate = NSDate()
  
  private lazy var dateStackView: UIStackView = {
    let stackView = UIStackView(frame: CGRectZero)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.distribution = .FillEqually
    stackView.spacing = 1.0
    self.view.addSubview(stackView)
    
    return stackView
  }()
  
  // MARK: View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .whiteColor()
    
    // Prepare the layout for the dateStackView
    self.dateStackView.topAnchor.constraintEqualToAnchor(self.view.topAnchor).active = true
    self.dateStackView.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor).active = true
    self.dateStackView.trailingAnchor.constraintEqualToAnchor(self.view.trailingAnchor).active = true
    self.dateStackView.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor).active = true
  }
  
  // MARK: Public Methods
  /// This method destroys and rebuilds the calendar view, based on the latest available data.
  func constructDates() {
    for view in self.dateStackView.arrangedSubviews {
      self.dateStackView.removeArrangedSubview(view)
    }
    
    for x in 0..<7 {
      // Construct the subviews and add them to the stack
      let view = UIView()
      view.tag = x // we use the tag as a quick/simple way to keep track of the represented day of the week
      view.translatesAutoresizingMaskIntoConstraints = false
      view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "dateTapped:"))
      
      let label = UILabel()
      label.textAlignment = .Center
      label.numberOfLines = 2
      label.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(label)
      
      label.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
      label.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
      self.dateStackView.addArrangedSubview(view)
      
      // construct the date and customize the view
      let currentDate = self.constructDateWithOffsetFromCurrentDate(view.tag)
      let shortDateString = self.createShortFormattedDateString(currentDate)
      
      if NSCalendar.currentCalendar().isDate(currentDate, inSameDayAsDate: self.selectedDate) {
        view.backgroundColor = CLLightBlue
        label.textColor = .whiteColor()
      } else {
        view.backgroundColor = CLWhite
      }
      
      if let chats = self.delegate?.provideChatsForDate(currentDate) {
        label.text = "\(chats.count)\n\(shortDateString)"
      }
    }
  }
  
  func dateTapped(sender: UITapGestureRecognizer) {
    guard let tappedView = sender.view else { return }
    
    // construct the date
    let offset = tappedView.tag
    self.selectedDate = self.constructDateWithOffsetFromCurrentDate(offset)
    
    self.delegate?.dateTapped(self.selectedDate)
  }
  
  // MARK: Private Methods
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
  
  private func createShortFormattedDateString(date: NSDate) -> String {
    let formatter = NSDateFormatter()
    formatter.timeStyle = .NoStyle
    formatter.dateFormat = "E"
    
    return formatter.stringFromDate(date)
  }
  
}
