//
//  PlusButton.swift
//  ChatLog
//
//  Created by David Baker on 3/3/16.
//  Copyright © 2016 Worth Baker. All rights reserved.
//

import UIKit

class PlusButton: UIButton {
  
  var fillColor: UIColor = UIColor.greenColor()
  
  override func drawRect(rect: CGRect) {
    // make the circile
    let path = UIBezierPath(ovalInRect: rect)
    self.fillColor.setFill()
    path.fill()
    
    // make the horizontal stroke
    let plusHeight: CGFloat = 3.0
    let plusWidth: CGFloat = min(self.bounds.width, self.bounds.height) * 0.6
    
    let plusPath = UIBezierPath()
    plusPath.lineWidth = plusHeight
    
    let aliasOffset: CGFloat = 0.5
    plusPath.moveToPoint(
      CGPoint(
        x: self.bounds.width / 2 - plusWidth / 2 + aliasOffset,
        y: self.bounds.height / 2 + aliasOffset
      ))
    
    plusPath.addLineToPoint(
      CGPoint(
        x: self.bounds.width / 2 + plusWidth / 2 + aliasOffset,
        y: self.bounds.height / 2 + aliasOffset
      ))
    
    // make the vertical stroke
    plusPath.moveToPoint(
      CGPoint(
        x: self.bounds.width / 2 + aliasOffset,
        y: self.bounds.height / 2 - plusWidth / 2 + aliasOffset
      ))
    plusPath.addLineToPoint(
      CGPoint(
        x: self.bounds.width / 2 + aliasOffset,
        y: self.bounds.height / 2 + plusWidth / 2 + aliasOffset
      ))
    
    UIColor.whiteColor().setStroke()
    plusPath.stroke()
  }
  
  override func willMoveToSuperview(newSuperview: UIView?) {
    // get more sophisticated with this
    self.showsTouchWhenHighlighted = true
  }
  
}