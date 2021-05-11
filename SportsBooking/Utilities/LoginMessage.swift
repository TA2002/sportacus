//
//  LoginMessage.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 11.05.2021.
//

import Foundation

enum LoginMessage: String, Error {
    case success = "User signs in successfully!"
    case operationNotAllowed = "Operation not allowed"
    case userDisabled = "The user account has been disabled by an administrator."
    case wrongPassword = "The password is invalid or the user does not have a password."
    case invalidEmail = "Indicates the email address is malformed."
}
