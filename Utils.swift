//
//  Utils.swift
//  OpenAppUITests
//
//  Created by Artem Vybornov on 18.01.2022.
//  Copyright © 2022 Open Technologies. All rights reserved.
//

import Foundation

struct Utils {
    
    static func generateNewChatComment() -> String {
        return "New chat by XCUITest #\(generateRandomValue())"
    }
    
    static func generateComment() -> String {
        return "New comment by XCUITest #\(generateRandomValue())"
    }
    
    static func generateDmComment() -> String {
        return "New DM by XCUITest #\(generateRandomValue())"
    }
    
    private static func generateRandomValue() -> Int {
        return Int.random(in: 0..<1000)
    }
}
