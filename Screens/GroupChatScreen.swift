//
//  GroupChatScreee.swift
//  OpenAppUITests
//
//  Created by Artem Vybornov on 29.03.2022.
//  Copyright © 2022 Open Technologies. All rights reserved.
//

import Foundation
import XCTest

struct GroupChatScreen: Screen {
    
    // MARK: - Constants
    
    private enum Elements {
        static let messageNotSentErrorText = "Couldn't send message. Tap to try again."
        static let moreButton = "more"
        static let archiveButton = "Archive"
        static let unarchiveButton = "Unarchive"
        static let viewDetailsButton = "View Details"
        static let muteButton = "notifications"
        static let unmuteButton = "notifications off"
        static let conversationMutedSnackbar = "Conversation muted."
        static let conversationUnmutedSnackbar = "Conversation unmuted."
        static let conversationArchivedSnackbar = "Conversation archived."
        static let conversationUnarchivedSnackbar = "Conversation unarchived."
        static let deleteMessageButton = "Delete Message"
        static let tryAgainButton = "Try Again"
        static let followButton = "Follow"
        static let followedSnackBar = "Added to your Conversations."
        static let blockUserOption = "Block User"
        static let unblockUserOption = "Unblock User"
        static let userNickname = "honest sparrow (friend)"
        static let backButton = "Back"
    }
    
    // MARK: - Public properties
    
    var app: XCUIApplication
    
    // Screen elements
    let messageNotSentErrorText: XCUIElement
    let moreButton: XCUIElement
    let archiveButton: XCUIElement
    let viewDetailsButton: XCUIElement
    let muteButton: XCUIElement
    let unmuteButton: XCUIElement
    let conversationMutedSnackbar: XCUIElement
    let conversationUnmutedSnackbar: XCUIElement
    let deleteMessageButton: XCUIElement
    let tryAgainButton: XCUIElement
    let followButton: XCUIElement
    let followedSnackBar: XCUIElement
    let blockUserOption: XCUIElement
    let unblockUserOption: XCUIElement
    let unarchiveButton: XCUIElement
    let conversationArchivedSnackbar: XCUIElement
    let conversationUnarchivedSnackbar: XCUIElement
    let userNickname: XCUIElement
    let backButton: XCUIElement
    
    // MARK: - init
    
    init(app: XCUIApplication) {
        self.app = app
        self.messageNotSentErrorText = app.staticTexts[Elements.messageNotSentErrorText]
        self.moreButton = app.buttons[Elements.moreButton]
        self.archiveButton = app.buttons[Elements.archiveButton]
        self.unarchiveButton = app.buttons[Elements.unarchiveButton]
        self.viewDetailsButton = app.buttons[Elements.viewDetailsButton]
        self.muteButton = app.buttons[Elements.muteButton]
        self.unmuteButton = app.buttons[Elements.unmuteButton]
        self.conversationMutedSnackbar = app.staticTexts[Elements.conversationMutedSnackbar]
        self.conversationUnmutedSnackbar = app.staticTexts[Elements.conversationUnmutedSnackbar]
        self.conversationArchivedSnackbar = app.staticTexts[Elements.conversationArchivedSnackbar]
        self.conversationUnarchivedSnackbar = app.staticTexts[Elements.conversationUnarchivedSnackbar]
        self.deleteMessageButton = app.buttons[Elements.deleteMessageButton]
        self.tryAgainButton = app.buttons[Elements.tryAgainButton]
        self.followButton = app.buttons[Elements.followButton]
        self.followedSnackBar = app.staticTexts[Elements.followedSnackBar]
        self.blockUserOption = app.staticTexts[Elements.blockUserOption]
        self.unblockUserOption = app.staticTexts[Elements.unblockUserOption]
        self.userNickname = app.buttons[Elements.userNickname]
        self.backButton = app.buttons[Elements.backButton]
    }
    
    // MARK: - Public methods

    func openMoreOptions() {
        moreButton.tap()
    }
    
    func muteConversation() {
        muteButton.tap()
    }
    
    func unmuteConversation() {
        unmuteButton.tap()
    }
    
    func resendFailedMessage() {
        tryAgainButton.tap()
    }
    
    func followChat() {
        followButton.tap()
    }
    
    func reportMessage() {
        let reportMessageButton = app.buttons["Report Message"]
        reportMessageButton.tap()
    }
    
    func directMessage() {
        let messageButton = app.staticTexts["Direct Message"]
        messageButton.tap()
    }
    
    func selectBlockUserOption() {
        blockUserOption.tap()
    }
    
    func unblockUser() {
        unblockUserOption.tap()
    }
    
    func blockUser() {
        let blockUserButton = app.buttons["Block User"]
        blockUserButton.tap()
    }
    
    func openUserMiniProfile() {
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", "honest sparrow (friend)")
        let nicknames = app.buttons.containing(predicate)
        let nickname = nicknames.element(boundBy: 1)
        nickname.tap()
    }
    
    func archiveConversation() {
        archiveButton.tap()
    }
    
    func unarchiveConversation() {
        unarchiveButton.tap()
    }
}
