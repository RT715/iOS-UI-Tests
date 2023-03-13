//
//  Alerts.swift
//  OpenAppUITests
//
//  Created by Artem Vybornov on 20.01.2022.
//  Copyright © 2022 Open Technologies. All rights reserved.
//

import Foundation

enum Alert {
    
    case noInternetConnection
    case allowNotifications
    case connectContacts
    case inviteAllContacts
    case signOut
    
    var title: String {
        switch self {
            case.noInternetConnection: return "Error"
            case.allowNotifications: return "“Open” Would Like to Send You Notifications"
            case.connectContacts: return "“Open” Would Like to Access Your Contacts"
            case.inviteAllContacts: return "Invite All Contacts"
            case.signOut: return "Sign out of Open"
        }
    }
    
    var text: String {
        switch self {
            case.noInternetConnection: return "No internet connection. Please try again."
            case.allowNotifications: return """
                                             Notifications may include alerts, sounds, and icon badges. \
                                             These can be configured in Settings.
                                             """
            case.connectContacts: return """
                                          Open uses your contacts (uploaded to our server) to show you \
                                          conversations from your friends.
                                          """
            case.inviteAllContacts: return """
                                             Send anonymous text message invites to all your contacts. \
                                             This helps everyone stay anonymous.
                                             """
            case.signOut: return "Are you sure you want to sign out of Open?"
        }
    }
    
    var acceptButtonTitle: String {
        switch self {
            case.noInternetConnection: return "Ok"
            case.allowNotifications: return "Allow"
            case.connectContacts: return "OK"
            case.inviteAllContacts: return "Invite All"
            case.signOut: return "Sign out"
        }
    }
    
    var declineButtonTitle: String {
        switch self {
            case.noInternetConnection: return ""
            case.allowNotifications: return "Don’t Allow"
            case.connectContacts: return "Don’t Allow"
            case.inviteAllContacts: return "Cancel"
            case.signOut: return "Cancel"
        }
    }
}
