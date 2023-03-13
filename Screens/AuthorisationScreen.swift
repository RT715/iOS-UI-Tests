//
//  AuthorisationScreen.swift
//  AppUITests
//
//  Created by Artem Vybornov on 30.11.2021.
//  Copyright © 2021 Open Technologies. All rights reserved.
//

import Foundation
import XCTest

struct AuthorisationScreen: Screen {
    
    // MARK: - Constants
    
    private enum Elements {
        static let phoneNumberStaticText = "Hi, what's your phone number?"
        static let countrySelectionFieldId = "countrySelectionField"
        static let phoneNumberField = "phoneNumberField"
        static let nextButton = "Next"
        static let incorrectPhoneErrorLabel = "incorrectPhoneErrorLabel"
    }
    
    // MARK: - Public properties
    
    let app: XCUIApplication
    
    // Screen elements
    let phoneNumberStaticText: XCUIElement
    let countrySelectionField: XCUIElement
    let phoneNumberField: XCUIElement
    let nextButton: XCUIElement
    let noInternetAlertStaticText: XCUIElement
    let incorrectPhoneErrorLabel: XCUIElement
    
    // MARK: - init
    
    init(app: XCUIApplication) {
        self.app = app
        phoneNumberStaticText = app.staticTexts[Elements.phoneNumberStaticText]
        countrySelectionField = app.textFields[Elements.countrySelectionFieldId]
        phoneNumberField = app.textFields[Elements.phoneNumberField]
        nextButton = app.buttons[Elements.nextButton]
        noInternetAlertStaticText = app.staticTexts[Alert.noInternetConnection.title]
        incorrectPhoneErrorLabel = app.staticTexts[Elements.incorrectPhoneErrorLabel]
    }
    
    // MARK: - Public methods
    
    func selectCountry(_ areaCode: String) {
        countrySelectionField.tap()
        app.pickerWheels.element.adjust(toPickerWheelValue: areaCode)
        let doneButton = app.toolbars["Toolbar"].buttons["Done"]
        doneButton.tap()
    }
    
    func typePhoneNumberAndProceed(phoneNumber: String) {
        phoneNumberField.typeText(phoneNumber)
        nextButton.tap()
    }
}
