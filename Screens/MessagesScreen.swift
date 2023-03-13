//
//  MessagesScreen.swift
//  OpenAppUITests
//
//  Created by Artem Vybornov on 29.09.2022.
//  Copyright © 2022 Open Technologies. All rights reserved.
//

import Foundation
import XCTest

struct MessagesScreen: Screen {
    
    // MARK: - Constants
    
    private enum Elements {
        static let badge = "unreadMessagesCounter"
    }
    
    // MARK: - Public properties
    
    var app: XCUIApplication
    
    // Screen elements
    let badge: XCUIElement
    
    // MARK: - init
    
    init(app: XCUIApplication) {
        self.app = app
        self.badge = app.staticTexts[Elements.badge]
    }
}
