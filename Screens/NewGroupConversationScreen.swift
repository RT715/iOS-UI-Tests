//
//  NewGroupConversationScreen.swift
//  OpenAppUITests
//
//  Created by Artem Vybornov on 18.01.2022.
//  Copyright © 2022 Open Technologies. All rights reserved.
//

import Foundation
import XCTest

struct NewGroupConversationScreen: Screen {
    
    // MARK: - Constants
    
    private enum Elements {
        static let closeButton = "Close"
        static let shuffleButton = "repeat"
    }
    
    // MARK: - Public properties
    
    var app: XCUIApplication
    
    // Screen elements
    let closeButton: XCUIElement
    let shuffleButton: XCUIElement
    
    // MARK: - init
    
    init(app: XCUIApplication) {
        self.app = app
        self.closeButton = app.buttons[Elements.closeButton]
        self.shuffleButton = app.buttons[Elements.shuffleButton]
    }
    
    // MARK: - Public methods

    func closeScreenAfterCreatingConversation() {
        closeButton.tap()
    }
    
    func generateNewNickname() {
        shuffleButton.tap()
    }
}
