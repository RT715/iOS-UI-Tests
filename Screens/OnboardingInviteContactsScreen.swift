//
//  InviteContactsScreen.swift
//  OpenAppUITests
//
//  Created by Artem Vybornov on 13.01.2022.
//  Copyright © 2022 Open Technologies. All rights reserved.
//

import Foundation
import XCTest

struct OnboardingInviteContactsScreen: Screen {
    
    // MARK: - Constants
    
    private enum Elements {
        static let inviteOkButton = "OK"
        static let inviteAllButton = "Invite All Contacts"
        static let dontInviteButton = "Not right now"
    }
    
    // MARK: - Public properties
    
    var app: XCUIApplication
    
    // Screen elements
    let inviteOkButton: XCUIElement
    let inviteAllButton: XCUIElement
    let dontInviteButton: XCUIElement
    
    // MARK: - init
    
    init(app: XCUIApplication) {
        self.app = app
        self.inviteOkButton = app.buttons[Elements.inviteOkButton]
        self.inviteAllButton = app.buttons[Elements.inviteAllButton]
        self.dontInviteButton = app.buttons[Elements.dontInviteButton]
    }
    
    // MARK: - Public methods
    
    func inviteContacts() {
        inviteOkButton.tap()
    }

    func inviteAllContacts() {
        inviteAllButton.tap()
    }
    
    func dontInviteAllContats(){
        dontInviteButton.tap()
    }
}
