//
//  ResetMessage.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 12.05.2021.
//

import Foundation

enum ResetMessage: String, Error {
    case userNotFound = "The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section."
    case invalidEmail = "The email address is badly formatted."
    case invalidRecipientEmail = "Indicates an invalid recipient email was sent in the request."
    case invalidSender = "Indicates an invalid sender email is set in the console for this action."
    case invalidMessagePayload = "Indicates an invalid email template for sending update email."
    case success = "Reset password email has been successfully sent"
}
