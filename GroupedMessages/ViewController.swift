//
//  ViewController.swift
//  GroupedMessages
//
//  Created by Mollie Gerber on 12/19/18.
//  Copyright © 2018 Mollie Gerber. All rights reserved.
//

import UIKit

//Properties of each message
struct ChatMessage {
    let text: String
    let isIncoming: Bool
    let date: Date
}

extension Date {
    
    static func dateFromCustomString(customString:String) -> Date {
        
        let dateFormatter = DateFormatter()        // format date
        dateFormatter.dateFormat = "mm/dd/yyyy"    // to make it easier to read
        
        return dateFormatter.date(from: customString) ?? Date()
    }
    
}

class ViewController: UITableViewController {
    
    fileprivate let cellId = "id123"
    
    var chatMessages = [[ChatMessage]]()
    
    
    // 2-Dimensional array for message strings
    let messagesFromServer = [
        
        ChatMessage(text: "This is my first mesasage", isIncoming: true, date: Date.dateFromCustomString(customString: "10/31/2018")),
        ChatMessage(text: "I'm going to make another long message to test the wrapping", isIncoming: true, date: Date.dateFromCustomString(customString: "10/31/2018")),
        ChatMessage(text: "I'm going to make another long message to test the wrapping. I'm going to make another long message to test the wrapping", isIncoming: false, date: Date.dateFromCustomString(customString: "11/15/2018")),
        ChatMessage(text: "Yo dawg, waddup?", isIncoming: false, date: Date.dateFromCustomString(customString: "11/15/2018")),
        ChatMessage(text: "This text should appear on the left side of the screen with a white background", isIncoming: true, date: Date.dateFromCustomString(customString: "11/15/2018")),
        ChatMessage(text: "Third section message.", isIncoming: true, date: Date.dateFromCustomString(customString: "11/27/2018"))
    
    ]

    // creates a label for each text without using storyboard
    class DateHeaderLabel: UILabel {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            backgroundColor = .black
            textColor = .white
            textAlignment = .center
            translatesAutoresizingMaskIntoConstraints = false     // enables auto layout
            font = UIFont.boldSystemFont(ofSize: 14)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override var intrinsicContentSize: CGSize {                     // creates a bubble shape for
                                                                        // each text instead of default
            let originalContentSize = super.intrinsicContentSize        // table cells
            let height = originalContentSize.height + 12
            layer.cornerRadius = height / 2
            layer.masksToBounds = true
            
            return CGSize(width: originalContentSize.width + 20, height: height)
        }
    }
    
    fileprivate func attemptToAssembleGroupedMessages() {
        
        let groupedMessages = Dictionary(grouping: messagesFromServer) { (element) -> Date in
            return element.date
        }
        
        //sort keys in order of date
        let sortedKeys = groupedMessages.keys.sorted()          // this section of code should sort by dates
        sortedKeys.forEach { (key) in                           // with newest showing at the bottom, however
                                                                // none of the dates are shown in order
            let values = groupedMessages[key]                   // not sure why this doesnt work
            chatMessages.append(values ?? [])

        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        attemptToAssembleGroupedMessages()        // load in grouped messages from server
        
        //The rest is styling for ViewController
        navigationItem.title = "Messages"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return chatMessages.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let firstMessageInSection = chatMessages[section].first {
            
            // create new date variable and formats value
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "mm/dd/yyyy"
            let dateString = dateFormatter.string(from: firstMessageInSection.date)
            
            
            let label = DateHeaderLabel()       // connect label class to label in view
            label.text = dateString             // passes in string
            
            let containerView = UIView()
            
            containerView.addSubview(label)     // puts label in UIView
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            
            
            return containerView

        }

        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return chatMessages[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatMessageCell
        
        let chatMessage = chatMessages[indexPath.section][indexPath.row]
        
        cell.chatMessage = chatMessage
        
        return cell
        
    }
}

