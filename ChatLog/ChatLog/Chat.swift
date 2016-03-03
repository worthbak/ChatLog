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
  var score: Int {
    return title.characters.count > 10 ? 5 : 1
  }
  
  // more metadata can be added later
  let title: String
  
  init(withTitle title: String, withDate date: NSDate = NSDate()) {
    self.date = date
    
    if title.characters.count > 0 {
      self.title = title
    } else {
      self.title = "New Chat"
    }
  }
}

// TODO: make a static func for "modifying" an immutable Chat struct