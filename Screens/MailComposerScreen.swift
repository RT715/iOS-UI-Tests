//
//  MailComposerScreen.swift
//  OpenAppUITests
//
//  Created by Artem Vybornov on 14.01.2022.
//  Copyright © 2022 Open Technologies. All rights reserved.
//

import Foundation
import XCTest

struct MailComposerScreen: Screen {
    
    // MARK: - Constants
    
    private enum Elements {
        static let mailSendButton = "Mail.sendButton"
    }
    
    // MARK: - Public properties
    
    var app: XCUIApplication
    
    // Screen elements
    let mailSendButton: XCUIElement
    
    // MARK: - init
    
    init(app: XCUIApplication) {
        self.app = app
        self.mailSendButton = app.buttons[Elements.mailSendButton]
    }
}
