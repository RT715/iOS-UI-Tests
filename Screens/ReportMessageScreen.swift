//
//  ReportMessageScreen.swift
//  OpenAppUITests
//
//  Created by Artem Vybornov on 09.09.2022.
//  Copyright © 2022 Open Technologies. All rights reserved.
//

import Foundation
import XCTest

struct ReportMessageScreen: Screen {
    
    enum ReportMessageReasons: String {
        case mean = "Mean"
        case judgmental = "Judgmental"
        case dishonest = "Dishonest"
        case other = "Other"
    }
    
    // MARK: - Public properties
    
    var app: XCUIApplication
    
    // MARK: - Public methods
    
    func report(for reason: ReportMessageReasons) {
        let reportReason = app.staticTexts[reason.rawValue]
        reportReason.tap()
    }
}
