//
//  OtherReasonReportScreen.swift
//  OpenAppUITests
//
//  Created by Artem Vybornov on 09.09.2022.
//  Copyright © 2022 Open Technologies. All rights reserved.
//

import Foundation
import XCTest

struct OtherReasonReportScreen: Screen {
    
    // MARK: - Public properties
    
    var app: XCUIApplication
    
    // MARK: - Public methods
    
    func submitReport() {
        let reportText = "XCUITest report comment"
        let submitButton = app.buttons["Submit"]
        let messageField = app.textViews["messageInputTextView"]
        messageField.tap()
        messageField.typeText(reportText)
        submitButton.tap()
    }
}
