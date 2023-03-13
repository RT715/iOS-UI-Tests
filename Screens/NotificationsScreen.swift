//
//  NotificationsScren.swift
//  OpenAppUITests
//
//  Created by Artem Vybornov on 11.01.2022.
//  Copyright © 2022 Open Technologies. All rights reserved.
//

import Foundation
import XCTest

struct NotificationsScreen: Screen {
    
    // MARK: - Constants
    
    private enum Elements {
        static let allowButton = "Allow"
        static let continueButton = "Continue"
    }
    
    // MARK: - Public properties
    
    var app: XCUIApplication
    
    // Screen elements
    let allowButton: XCUIElement
    let continueButton: XCUIElement
    
    // MARK: - init
    
    init(app: XCUIApplication) {
        self.app = app
        self.allowButton = app.buttons[Elements.allowButton]
        self.continueButton = app.buttons[Elements.continueButton]
    }
    
    // MARK: - Public methods
    
    func allowNotificationsInviteFlow() {
        allowButton.tap()
    }
    
    func allowNotifications() {
        continueButton.tap()
    }
}
