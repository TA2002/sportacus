//
//  LoginMessage.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 11.05.2021.
//

import Foundation

enum LoginMessage: String, Error {
    case success = "Пользователь успешно вошел в систему!!"
    case operationNotAllowed = "Операция невозможна"
    case userDisabled = "Учетная запись была заблокирована администратором"
    case wrongPassword = "Неверный пароль"
    case invalidEmail = "Неверный формат эл. почты."
}
