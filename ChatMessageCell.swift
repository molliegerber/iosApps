//
//  ChatMessageCell.swift
//  GroupedMessages
//
//  Created by Mollie Gerber on 12/19/18.
//  Copyright © 2018 Mollie Gerber. All rights reserved.
//

import UIKit

class ChatMessageCell: UITableViewCell {

    let messageLabel = UILabel()
    let bubbleBackgroundView = UIView()
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    
    
    var chatMessage: ChatMessage! {
        
        didSet {
            
            // Styling for chat bubbles
            bubbleBackgroundView.backgroundColor = chatMessage.isIncoming ? .white : .darkGray
            messageLabel.textColor = chatMessage.isIncoming ? .black : .white
            
            messageLabel.text = chatMessage.text    // pass in messages from array
            
            // If text is incoming, left justify
            if chatMessage.isIncoming {
                leadingConstraint.isActive = true
                trailingConstraint.isActive = false
            }
            
            // If text is outgoing, right justify
            else {
                leadingConstraint.isActive = false
                trailingConstraint.isActive = true
                
                
            }
        }
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        // Styling
        backgroundColor = .clear
        bubbleBackgroundView.layer.cornerRadius = 12
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bubbleBackgroundView)
        
        
        addSubview(messageLabel)            // passes label into cell
        
        messageLabel.numberOfLines = 0      // allows each cell tp wrap the string, which
                                            // basically makes more than 1 line if needed
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        //SETTING UP CONTRAINTS FOR OUR LABEL
        let constriants = [
                            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
                            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -32),
                            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
                            bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
                            bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
                            bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
                            bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16),
        
                            ]
        
        // Apply necessary constraints to label
        NSLayoutConstraint.activate(constriants)
        
        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        leadingConstraint.isActive = false
        
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        trailingConstraint.isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
