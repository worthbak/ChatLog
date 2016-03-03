//
//  ChatDataController.swift
//  ChatLog
//
//  Created by David Baker on 3/3/16.
//  Copyright © 2016 Worth Baker. All rights reserved.
//

import Foundation

/// Very basic implementation of an encapsulated data/persistence controller.
/// Given more time, local caching (via CoreData) would be quite simple to add.
class ChatDataController {
  
  private var chats = [Chat]()
  
  func provideChatsForDate(date: NSDate) -> [Chat] {
    var chatsToReturn = [Chat]()
    for chat in self.chats where NSCalendar.currentCalendar().isDate(chat.date, inSameDayAsDate: date) {
      chatsToReturn.append(chat)
    }
    
    return chatsToReturn
  }
  
  func addNewChat(chat: Chat) {
    self.chats.append(chat)
  }
  
}