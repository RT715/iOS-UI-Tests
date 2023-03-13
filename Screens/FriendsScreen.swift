//
//  FriendsScreen.swift
//  OpenAppUITests
//
//  Created by Artem Vybornov on 18.04.2022.
//  Copyright © 2022 Open Technologies. All rights reserved.
//

import Foundation
import XCTest

struct FriendsScreen: Screen {
    
    // MARK: - Constants
    
    private enum Elements {
        static let sendInvites = "Send anonymous invites"
    }
    
    // MARK: - Public properties
    
    var app: XCUIApplication
    
    // Screen elements
    let sendInvites: XCUIElement
    
    // MARK: - init
    
    init(app: XCUIApplication) {
        self.app = app
        self.sendInvites = app.staticTexts[Elements.sendInvites]
    }
    
    // MARK: - Public methods

    func goToInviteContactsScreen() {
        sendInvites.tap()
    }
}
