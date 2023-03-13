//
//  BaseTest.swift
//  AppUITests
//
//  Created by Artem Vybornov on 30.11.2021.
//  Copyright © 2021 Open Technologies. All rights reserved.
//

import XCTest

public class BaseTest: XCTestCase {
    
    enum Tabs: Int {
        case newConversationsTab = 0
        case messagesTab = 1
        case accountTab = 2
    }

    // MARK: - Public properties
    
    let app = XCUIApplication()
    
    // MARK: - Set up and tear down
    
    public override func setUp() {
        continueAfterFailure = false
        app.launchArguments = ["testing"]
        app.launch()
    }
    
    public override func tearDown() {
        let screenshot = XCUIScreen.main.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.lifetime = .deleteOnSuccess
        add(attachment)
        app.terminate()
    }
    
    // MARK: - Public methods
    
    func waitForElementToAppear(element: XCUIElement, time: Double) {
        let existsPredicate = NSPredicate(format: "exists == true")
        expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: time, handler: nil)
        XCTAssert(element.exists)
    }
        
    func turnWifiOff() {
        return switchInternetConnection()
    }
    
    func turnWifiOn() {
        return switchInternetConnection()
    }
    
    func handleAlert(title: String, buttonToTap: String) {
        let alert = app.alerts[title].firstMatch
        alert.buttons[buttonToTap].tap()
        XCTAssertFalse(alert.exists)
    }
    
    func handleSystemAlert(title: String, buttonToTap: String) {
        addUIInterruptionMonitor(withDescription: title) { (alert) -> Bool in
            alert.buttons[buttonToTap].tap()
            return true
          }
        app.tap()
    }
    
    func verifyTextInAlert(title: String, text: String) {
        let alert = app.alerts[title].firstMatch
        let alertText = alert.staticTexts[text]
        XCTAssertTrue(alertText.exists, "The text is different")
    }
    
    func deleteApp() {
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        app.terminate()
        
        let appIcon = springboard.icons["Open"]
        if appIcon.exists {
            appIcon.press(forDuration: 2)
        } else {
            XCTFail("Failed to find the app icon.")
        }
        
        let removeAppButton = springboard.buttons["Remove App"]
        if removeAppButton.waitForExistence(timeout: 5) {
            removeAppButton.tap()
        } else {
            XCTFail("Failed to find the 'Remove App' button.")
        }

        let deleteAppButton = springboard.alerts.buttons["Delete App"]
        if deleteAppButton.waitForExistence(timeout: 5) {
            deleteAppButton.tap()
        } else {
            XCTFail("Failed to find 'Delete App' button.")
        }
        
        let finalDeleteButton = springboard.alerts.buttons["Delete"]
        if finalDeleteButton.waitForExistence(timeout: 5) {
            finalDeleteButton.tap()
        } else {
            XCTFail("Failed to find 'Delete' button.")
        }
        
        XCTAssertFalse(
            appIcon.exists,
            "The app hasn't been deleted."
        )
    }
    
    func switchToTab(_ tab: Tabs) {
        let button = app.tabBars["Tab Bar"].children(matching: .button).element(boundBy: tab.rawValue)
        button.tap()
    }
    
    func goToNewGroupConversationScreen() {
        let startConversationButton = app.buttons["startConversationButton"]
        startConversationButton.tap()
    }
    
    // MARK: - Private methods
    
    private func switchInternetConnection() {
        let settings = XCUIApplication(bundleIdentifier: "com.apple.Preferences")
        settings.activate()
        settings.tables.cells["Wi-Fi"].tap()
        settings.switches["Wi-Fi"].tap()
        settings.terminate()
        app.activate()
    }
}
