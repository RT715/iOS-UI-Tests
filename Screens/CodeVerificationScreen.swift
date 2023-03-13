//
//  CodeVerificationScreen.swift
//  OpenAppUITests
//
//  Created by Artem Vybornov on 20.12.2021.
//  Copyright © 2021 Open Technologies. All rights reserved.
//

import Foundation
import XCTest

struct CodeVerificationScreen: Screen {
    
    // MARK: - Constants
    
    private enum Elements {
        static let codeField = "codeField"
        static let nextButton = "Next"
    }
    
    // MARK: - Public properties
    
    var app: XCUIApplication
    
    // Screen elements
    let codeField: XCUIElement
    let nextButton: XCUIElement
    
    // MARK: - init
    
    init(app: XCUIApplication) {
        self.app = app
        codeField = app.textFields[Elements.codeField]
        nextButton = app.buttons[Elements.nextButton]
    }
    
    // MARK: - Public methods
    
    func typeVerificationCodeAndProceed(code: String) {
        codeField.typeText(code)
    }
}
