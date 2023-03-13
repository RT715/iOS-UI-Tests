//
//  NewConversationsScreen.swift
//  OpenAppUITests
//
//  Created by Artem Vybornov on 03.08.2022.
//  Copyright © 2022 Open Technologies. All rights reserved.
//

import Foundation
import XCTest

struct NewConversationsScreen: Screen {
    
    // MARK: - Contants
    
    private enum Elements {
        static let newConversationsScreenTitle = "New Conversations"
    }
    
    // MARK: - Public properties
    
    var app: XCUIApplication
    
    // Screen elements
    let newConversationsScreenTitle: XCUIElement
    
    // MARK: - init
    
    init(app: XCUIApplication) {
        self.app = app
        self.newConversationsScreenTitle = app.staticTexts[Elements.newConversationsScreenTitle]
    }
    
    // MARK: - Public methods
    
    func pullToRefresh() {
        let firstChatCell = app.tables.cells.firstMatch
        let startPosition = firstChatCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let endPosition = firstChatCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 2.5))
        startPosition.press(forDuration: 0, thenDragTo: endPosition, withVelocity: 2000, thenHoldForDuration: 0)
    }
    
    func dismissBanner() {
        let gotItButton = app.buttons["Got It"]
        gotItButton.tap()
    }
}
