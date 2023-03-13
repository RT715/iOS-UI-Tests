//
//  DmChatScreen.swift
//  OpenAppUITests
//
//  Created by Artem Vybornov on 16.09.2022.
//  Copyright © 2022 Open Technologies. All rights reserved.
//

import Foundation
import XCTest

struct DmChatScreen: Screen {
    
    // MARK: - Constants
    
    private enum Elements {
        static let archiveButton = "archive"
    }
    
    // MARK: - Public properties
    
    var app: XCUIApplication
    
    // Screen elements
    let archiveButton: XCUIElement
    
    // MARK: - init
    
    init(app: XCUIApplication) {
        self.app = app
        self.archiveButton = app.buttons[Elements.archiveButton]
    }
    
    // MARK: - Public methods
    
    func archiveConversation() {
        archiveButton.tap()
    }
    
    func unarchiveConversation() {
        archiveButton.tap()
    }
    
    func goToParentChat(_ parentChatTitle: String) {
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", parentChatTitle)
        let paretnChatTitleInBanner = app.staticTexts.matching(predicate).firstMatch
        paretnChatTitleInBanner.tap()
    }
}
