//
//  ConnectContactsScreen.swift
//  OpenAppUITests
//
//  Created by Artem Vybornov on 13.01.2022.
//  Copyright © 2022 Open Technologies. All rights reserved.
//

import Foundation
import XCTest

struct ConnectContactsScren: Screen {
    
    // MARK: - Constants
    
    private enum Elements {
        static let allowOkButton = "OK"
        static let continueButton = "Continue"
        static let contactUsButton = "Contact us"
    }
    
    // MARK: - Public properties
    
    var app: XCUIApplication
    
    // Screen elements
    let allowOkButton: XCUIElement
    let continueButton: XCUIElement
    let contactUsButton: XCUIElement
    
    // MARK: - init
    
    init(app: XCUIApplication) {
        self.app = app
        self.allowOkButton = app.buttons[Elements.allowOkButton]
        self.continueButton = app.buttons[Elements.continueButton]
        self.contactUsButton = app.buttons[Elements.contactUsButton]
    }
    
    // MARK: - Public methods
    
    func allowAccessToContactsInviteFlow() {
        allowOkButton.tap()
    }

    func allowAccessToContacts() {
        continueButton.tap()
    }
    
    func contactUs() {
        contactUsButton.tap()
    }
}
