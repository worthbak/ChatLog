//
//  ChatTableViewController.swift
//  ChatLog
//
//  Created by David Baker on 3/3/16.
//  Copyright © 2016 Worth Baker. All rights reserved.
//

import UIKit

let ChatCellIdentifier = "chatCellID"

class ChatTableViewController: UITableViewController {
  
  var chatsForDisplay = [Chat]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: ChatCellIdentifier)
  }
  
  // MARK: - Table view data source
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return self.chatsForDisplay.count
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(ChatCellIdentifier, forIndexPath: indexPath)
    
    // Configure the cell...
    let chat = chatsForDisplay[indexPath.row]
    cell.textLabel?.text = chat.title
    
    return cell
  }
  
}
