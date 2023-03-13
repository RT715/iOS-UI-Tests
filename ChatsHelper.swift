//
//  ChatsHelper.swift
//  OpenAppUITests
//
//  Created by Artem Vybornov on 05.04.2022.
//  Copyright © 2022 Open Technologies. All rights reserved.
//

import Foundation
import XCTest

struct ChatsHelper: Screen {
    
    // MARK: - Public properties

    var app: XCUIApplication
    
    // MARK: - Public methods
    
    func sendMessage(_ messageText: String) {
        let messageField = app.textViews["messageInputTextView"]
        messageField.tap()
        messageField.typeText(messageText)
        let sendMessageButton = app.buttons["sendMessageButton"]
        sendMessageButton.tap()
    }
    
    func checkIfGroupChatTitleExists(_ chatTitle: String) -> Bool {
        let chatCells = app.tables.cells.allElementsBoundByIndex
            
        return chatCells.contains(where: { cell in
            let cellChatTitle = cell.staticTexts.element(boundBy: 1).firstMatch.label
            return cellChatTitle == chatTitle
        })
    }
    
    func checkIfLastDmMessageExists(_ dmMessage: String) -> Bool {
        let chatCells = app.tables.cells.allElementsBoundByIndex
            
        return chatCells.contains(where: { cell in
            let cellChatTitle = cell.staticTexts.element(boundBy: 0).firstMatch.label
            return cellChatTitle == dmMessage
        })
    }
    
    func findAndOpenChatOnMessagesFeed(_ title: String) {
        let chatCells = app.tables.cells.allElementsBoundByIndex
        for cell in chatCells {
            let cellChatTitle = cell.staticTexts[title].firstMatch
            if title == cellChatTitle.label {
                cellChatTitle.tap()
                break
            }
        }
    }
    
    func commentRejectionLabelExists(_ commentText: String) -> Bool {
        let commentsCells = app.collectionViews.cells
        let rejectionText = "Message not sent (other)"
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", rejectionText)
        let rejectionLabel = commentsCells.descendants(matching: .staticText).matching(predicate).firstMatch.label
        if rejectionLabel == rejectionText {
            return true
        }
        return false
    }
    
    func findAndOpenChatOnSuggestedFeed(_ title: String) {
        let tablesQuery = app.tables
        let chatTitle = tablesQuery.cells.containing(.staticText, identifier: title)
        chatTitle.element.tap()
    }
    
    func openFirstChat() {
        let firstChatCell = app.tables.cells.firstMatch
        firstChatCell.tap()
    }
    
    func followSuggestedChatFromSuggestedFeed(_ title: String) {
        let tablesQuery = app.tables
        let chatCell = tablesQuery.cells.containing(.staticText, identifier: title)
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", "Follow")
        let followButton = chatCell.staticTexts.matching(predicate).firstMatch
        followButton.tap()
    }
    
    func findComment(_ text: String) -> String {
        let commentsCells = app.collectionViews.cells.allElementsBoundByIndex
        
        for comment in commentsCells {
            let predicate = NSPredicate(format: "value CONTAINS[c] %@", text)
            let commentText = comment.textViews.containing(predicate).firstMatch.value as! String
            if text == commentText {
                return commentText
            }
        }
        return "Comment not found."
    }
    
    func checkIfBadgeExists(_ title: String) -> Bool {
        let chatsCells = app.tables.cells
        let chatCell = chatsCells.containing(.staticText, identifier: title)
        let badge = chatCell.staticTexts["unreadMessagesCounter"].firstMatch
        if badge.exists {
            return true
        }
        return false
    }
    
    func findCommentAsXcuiElement(_ text: String) -> XCUIElement {
        let commentsCells = app.collectionViews.cells.allElementsBoundByIndex
        
        var element: XCUIElement!
            for comment in commentsCells {
                let predicate = NSPredicate(format: "value CONTAINS[c] %@", text)
                let commentText = comment.textViews.containing(predicate).firstMatch
                if text == commentText.value as! String {
                    element = commentText
                    break
                }
            }
        return element
        }
        
    func longTap(over element: XCUIElement) {
        element.press(forDuration: 1)
    }
    
    func doubleTap(over element: XCUIElement) {
        element.doubleTap()
    }
    
    func getUserNickname() -> String {
        let searchText = "Message as"
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", searchText)
        let textInMessageField = app.staticTexts.containing(predicate).firstMatch.label
        let nicknameWithDots = textInMessageField.split(separator: " ", maxSplits: 2)[2]
        let nickname = nicknameWithDots.split(separator: ".")[0]
        return String(nickname)
    }
    
    func goBackFromChatScreen() {
        let backButton = app.buttons["Back"]
        backButton.tap()
    }
    
    func deleteComment() {
        let deleteButton = app.buttons["Delete Message"]
        deleteButton.tap()
    }
    
    func dismissSnackBar(_ element: XCUIElement) {
        element.doubleTap()
    }
    
    func goBackFromArchivedChat() {
        let backButton = app.buttons["Archived Conversations"]
        backButton.tap()
    }
}
