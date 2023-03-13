//
//  ParticipantsRulesScreen.swift
//  OpenAppUITests
//
//  Created by Artem Vybornov on 20.12.2021.
//  Copyright © 2021 Open Technologies. All rights reserved.
//

import Foundation
import XCTest

struct CommunityPrinciplesScreen: Screen {
    
    // MARK: - Constants
    
    private enum Elements {
        static let agreeButton = "I agree"
    }
    
    // MARK: - Public properties
    
    var app: XCUIApplication
    
    // Screen elements
    var agreeButton: XCUIElement
    
    // MARK: - init
    
    init(app: XCUIApplication) {
        self.app = app
        self.agreeButton = app.buttons[Elements.agreeButton]
    }
    
    // MARK: - Public methods
    
    func agreeWithRulesAndProceed() {
        agreeButton.tap()
    }
}
