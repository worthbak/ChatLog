//
//  Chat.swift
//  ChatLog
//
//  Created by David Baker on 3/3/16.
//  Copyright © 2016 Worth Baker. All rights reserved.
//

import Foundation

struct Chat {
  let date: NSDate
  let title: String
  
  // scoring metadata
  var attracted = false
  var wouldDate = false
  var didAskOut = false
  
  var score: Int {
    var calculatedScore = 1
    
    if wouldDate {
      calculatedScore += 1
    }
    
    if attracted {
      calculatedScore += 2
    }
    
    if didAskOut {
      calculatedScore += 3
    }
    
    return calculatedScore >= 4 ? 4 : calculatedScore
  }
  
  init(withTitle title: String, withDate date: NSDate = NSDate()) {
    self.date = date
    
    if title.characters.count > 0 {
      self.title = title
    } else {
      self.title = "New Chat"
    }
  }
}