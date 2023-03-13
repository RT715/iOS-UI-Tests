//
//  AccountScreen.swift
//  OpenAppUITests
//
//  Created by Artem Vybornov on 14.01.2022.
//  Copyright © 2022 Open Technologies. All rights reserved.
//

import Foundation
import XCTest

struct AccountScreen: Screen {
    
    // MARK: - Constants
    
    private enum Elements {
        static let friendsLabel = "Friends"
        static let signOutItem = "Sign Out"
        static let addFriendsButton = "Add Friends"
        static let closeButton = "Close"
        static let archivedConversationsOption = "Archived Conversations"
    }
    
    // MARK: - Public properties
    
    var app: XCUIApplication
    
    // Screen elements
    let friendsLabel: XCUIElement
    let signOutItem: XCUIElement
    let addFriendsButton: XCUIElement
    let closeButton: XCUIElement
    let archivedConversationsOption: XCUIElement
    
    // MARK: - init
    
    init(app: XCUIApplication) {
        self.app = app
        self.friendsLabel = app.staticTexts[Elements.friendsLabel]
        self.signOutItem = app.staticTexts[Elements.signOutItem]
        self.addFriendsButton = app.buttons[Elements.addFriendsButton]
        self.closeButton = app.buttons[Elements.closeButton]
        self.archivedConversationsOption = app.staticTexts[Elements.archivedConversationsOption]
    }
    
    // MARK: - Public methods
    
    func signOut() {
        signOutItem.tap()
    }
    
    func goToFriendsScreen() {
        addFriendsButton.tap()
    }
    
    func goBackHome() {
        closeButton.tap()
    }
    
    func goToArchivedConversationsScreen() {
        archivedConversationsOption.tap()
    }
}
