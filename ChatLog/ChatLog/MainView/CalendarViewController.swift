//
//  DateViewController.swift
//  ChatLog
//
//  Created by David Baker on 3/3/16.
//  Copyright © 2016 Worth Baker. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
  
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
    
    // Do any additional setup after loading the view.
    self.dateStackView.topAnchor.constraintEqualToAnchor(self.view.topAnchor).active = true
    self.dateStackView.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor).active = true
    self.dateStackView.trailingAnchor.constraintEqualToAnchor(self.view.trailingAnchor).active = true
    self.dateStackView.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor).active = true
    
    for x in 1...7 {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.backgroundColor = .lightGrayColor()
      
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.text = "\(x)"
      view.addSubview(label)
      
      label.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
      label.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
      self.dateStackView.addArrangedSubview(view)
    }
  }
  
}
