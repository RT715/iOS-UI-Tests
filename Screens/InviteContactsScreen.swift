//
//  InviteContactsScreen.swift
//  OpenAppUITests
//
//  Created by Artem Vybornov on 18.04.2022.
//  Copyright © 2022 Open Technologies. All rights reserved.
//

import Foundation
import XCTest

struct InviteContactsScreen: Screen {
    
    // MARK: - Constants
    
    private enum Elements {
        static let inviteContactsHeader = "Invite contacts"
    }
    
    // MARK: - Public properties
    
    var app: XCUIApplication
    
    // Screen elements
    let inviteContactsHeader: XCUIElement
    
    // MARK: - init
    
    init(app: XCUIApplication) {
        self.app = app
        self.inviteContactsHeader = app.staticTexts[Elements.inviteContactsHeader]
    }
}
