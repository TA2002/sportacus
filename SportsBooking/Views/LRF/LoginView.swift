//
//  LoginView.swift
//  DemoSwiftUI
//
//  Created by mac-00018 on 10/10/19.
//  Copyright © 2019 mac-00018. All rights reserved.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @ObservedObject var currentUserSession: UserSession
    //@Binding var session: UserSession
    //@EnvironmentObject var settings: UserSettings
    
    @State var email: String = ""
    @State var password: String = ""
    @State var alertMsg = ""
    
    @State private var showForgotPassword = false
    @State private var showSignup = false
    @State var showAlert = false
    @State var showDetails = false
    
    @State var loginSelection: Int? = nil
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var alert: Alert {
        Alert(title: Text(""), message: Text(alertMsg), dismissButton: .default(Text("OK")))
    }
    
    var body: some View {
        
        VStack {
            VStack {
                Spacer(minLength: (UIScreen.main.bounds.width * 15) / 414)
                RoundedImage()
                Spacer(minLength: (UIScreen.main.bounds.width * 15) / 414)
                VStack {
                    HStack {
                        Image("ic_email")
                            .padding(.leading, (UIScreen.main.bounds.width * 20) / 414)
                        
                        TextField("Электронный адрес", text: $email)
                            .frame(height: (UIScreen.main.bounds.width * 40) / 414, alignment: .center)
                            .padding(.leading, (UIScreen.main.bounds.width * 10) / 414)
                            .padding(.trailing, (UIScreen.main.bounds.width * 10) / 414)
                            .font(.system(size: (UIScreen.main.bounds.width * 15) / 414, weight: .regular, design: .default))
                            .imageScale(.small)
                            .keyboardType(.emailAddress)
                            .autocapitalization(UITextAutocapitalizationType.none)
                        
                    }
                    seperator()
                }
                Spacer(minLength: (UIScreen.main.bounds.width * 15) / 414)
                VStack {
                    
                    HStack {
                        Image("ic_password")
                            .padding(.leading, (UIScreen.main.bounds.width * 20) / 414)
                        
                        SecureField("Пароль", text: $password)
                            .frame(height: (UIScreen.main.bounds.width * 40) / 414, alignment: .center)
                            .padding(.leading, (UIScreen.main.bounds.width * 10) / 414)
                            .padding(.trailing, (UIScreen.main.bounds.width * 10) / 414)
                            .font(.system(size: (UIScreen.main.bounds.width * 15) / 414, weight: .regular, design: .default))
                            .imageScale(.small)
                    }
                    seperator()
                    
                }
                
                Spacer(minLength: (UIScreen.main.bounds.width * 15) / 414)
                
                VStack(alignment: .trailing) {
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            self.showForgotPassword = true
                        }) {
                            Text("Забыли Пароль?")
                                .foregroundColor(lightblueColor)
                                .font(.system(size: (UIScreen.main.bounds.width * 15) / 414, weight: .bold, design: .default))
                            
                        }.sheet(isPresented: self.$showForgotPassword) {
                            ForgotPasswordView(currentUserSession: currentUserSession)
                        }
                        
                    }.padding(.trailing, (UIScreen.main.bounds.width * 10) / 414)
                }
                
                
                VStack {
                    Spacer()
                    Button(action: {
                        if  self.isValidInputs() {
                            // For use with property wrapper
                            userLogin(email: email, password: password)
                            // ==========
                            
                            // For use with property wrapper
                            //                self.dataStore.loggedIn = true
                            // ==========
                        }
                        
                    }) {
                        buttonWithBackground(btnText: "Войти")
                    }
                    Spacer()
                }
                
                VStack {
                    Spacer(minLength: (UIScreen.main.bounds.width * 10) / 414)
                    Button(action: {
                        self.showSignup = true
                    }) {
                        Text("У вас нет учетной записи? Зарегистрироваться")
                            .foregroundColor(lightblueColor)
                            .font(.system(size: (UIScreen.main.bounds.width * 15) / 414, weight: .bold, design: .default))
                        
                    }.sheet(isPresented: self.$showSignup) {
                        SignUpView(currentUserSession: currentUserSession)
                    }
                    
                    Spacer(minLength: (UIScreen.main.bounds.width * 20) / 414)
                }
            }
                
            .alert(isPresented: $showAlert, content: { self.alert })
        }
    }
    
    
    private func userLogin(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error as? NSError {
                switch AuthErrorCode(rawValue: error.code) {
                    case .operationNotAllowed:
                        self.alertMsg = LoginMessage.operationNotAllowed.rawValue
                        self.showAlert.toggle()
                    case .userDisabled:
                        self.alertMsg = LoginMessage.userDisabled.rawValue
                        self.showAlert.toggle()
                    case .wrongPassword:
                        self.alertMsg = LoginMessage.wrongPassword.rawValue
                        self.showAlert.toggle()
                    case .invalidEmail:
                        self.alertMsg = LoginMessage.invalidEmail.rawValue
                        self.showAlert.toggle()
                    default:
                        print("Error: \(error.localizedDescription)")
                }
            }
            else {
                currentUserSession.userDidLogIn()
            }
        }
    }
    
    fileprivate func isValidInputs() -> Bool {
        
        if self.email == "" {
            self.alertMsg = "Адрес эл. почты не может быть пустым."
            self.showAlert.toggle()
            return false
        } else if !self.email.isValidEmail {
            self.alertMsg = "Неверный формат эл. почты."
            self.showAlert.toggle()
            return false
        } else if self.password == "" {
            self.alertMsg = "Пароль не может быть пустым."
            self.showAlert.toggle()
            return false
        } else if !(self.password.isValidPassword) {
            self.alertMsg = "Введенный пароль состоит из меньше чем 6 символов."
            self.showAlert.toggle()
            return false
        }
        
        return true
    }
    
}

class UserSettings: ObservableObject {
    
    @Published var loggedIn : Bool = false
}


struct RoundedImage: View {

    var body: some View {
        
        Image("sportacus")
           .resizable()
           .aspectRatio(contentMode: .fill)
            .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height / 9)
           .clipped()
           //.cornerRadius(150)
           .padding(.bottom, 25)
        
    }

}
