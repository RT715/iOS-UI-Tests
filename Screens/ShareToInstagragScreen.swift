//
//  ShareToInstagragScreen.swift
//  OpenAppUITests
//
//  Created by Artem Vybornov on 25.11.2022.
//  Copyright © 2022 Open Technologies. All rights reserved.
//

import Foundation
import XCTest

struct ShareToInstagramScreen: Screen {
    
    // MARK: - Constants
    
    private enum Elements {
        static let skipButton = "Skip this step"
    }
    
    // MARK: - Public properties
    
    var app: XCUIApplication
    
    // Screen elements
    let skipButton: XCUIElement
    
    // MARK: - init
    
    init(app: XCUIApplication) {
        self.app = app
        self.skipButton = app.buttons[Elements.skipButton]
    }
    
    // MARK: - Public methods
    
    func skipSharing() {
        skipButton.tap()
    }
}
