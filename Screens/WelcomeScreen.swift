//
//  WelcomeScreen.swift
//  AppUITests
//
//  Created by Artem Vybornov on 30.11.2021.
//  Copyright © 2021 Open Technologies. All rights reserved.
//

import Foundation
import XCTest

struct WelcomeScreen: Screen {
    
    // MARK: - Constants
    
    private enum Elements {
        static let getStarted = "Get Started"
    }
    
    // MARK: - Public properties
    
    let app: XCUIApplication
    
    // Screen elements
    let getStartedButton: XCUIElement
    
    // MARK: - init
    
    init(app: XCUIApplication) {
        self.app = app
        getStartedButton = app.buttons[Elements.getStarted]
    }
    
    // MARK: - Public methods
    
    func goToAuthorisationScreen() {
        getStartedButton.tap()
    }
}
