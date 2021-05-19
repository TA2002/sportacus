//
//  ResetMessage.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 12.05.2021.
//

import Foundation

enum ResetMessage: String, Error {
    case userNotFound = "Ошибка"
    case invalidEmail = "Неверный формат эл. адреса."
    case invalidRecipientEmail = "Неверный получатель."
    case invalidSender = "Неверный отправитель"
    case invalidMessagePayload = "Неправильный формат почты"
    case success = "Письмо для сброса пароля было успешно отправлено на вашу почту"
}
