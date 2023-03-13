//
//  ReportMessageSuccess.swift
//  OpenAppUITests
//
//  Created by Artem Vybornov on 09.09.2022.
//  Copyright © 2022 Open Technologies. All rights reserved.
//

import Foundation
import XCTest

struct ReportMessageSuccessScreen: Screen {
    
    // MARK: - Constants
    
    private enum Elements {
        static let thankYouStaticText = "Thank you"
    }
    // MARK: - Public properties
    
    var app: XCUIApplication
    
    // Screen elements
    let thankYouStaticText: XCUIElement
    
    // MARK: - init
    init(app: XCUIApplication) {
        self.app = app
        self.thankYouStaticText = app.staticTexts[Elements.thankYouStaticText]
    }
}
