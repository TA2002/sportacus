//
//  ErrorMessage.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 11.05.2021.
//

import Foundation

enum RegistrationMessage: String, Error {
    case success = "User successfully registered!"
    case operationNotAllowed = "Operation not allowed"
    case emailAlreadyInUse = "Sorry, email is already registered"
    case invalidEmail = "The email address is badly formatted."
    case weakPassword = "The password must be 6 characters long or more."
}
