//
//  Task+SleepSeconds.swift
//  OpenAppUITests
//
//  Created by Artem Vybornov on 14.10.2022.
//  Copyright © 2022 Open Technologies. All rights reserved.
//

import Foundation

extension Task where Success == Never, Failure == Never {
    static func sleep(seconds: Double) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: duration)
    }
}
