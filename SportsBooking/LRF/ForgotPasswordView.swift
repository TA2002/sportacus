//
//  ForgotPasswordView.swift
//  DemoSwiftUI
//
//  Created by mac-00018 on 10/10/19.
//  Copyright © 2019 mac-00018. All rights reserved.
//

import SwiftUI
import Firebase

struct ForgotPasswordView: View {
    
    @ObservedObject var currentUserSession: UserSession
    
    @State var email: String = ""
    @State var showAlert = false
    @State var alertMsg = ""

    var alert: Alert {
        Alert(title: Text(""), message: Text(alertMsg), dismissButton: .default(Text("OK")))
    }
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                VStack {
                    
                    Spacer(minLength: 80)
                    
                    Text("Write your email address in the text box and we will send you a verification code to reset your password.")
                        .font(.body)
                        .padding()
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)

                    VStack {
                        
                        HStack {
                            Image("ic_email")
                                .padding(.leading, 20)
                            
                            
                            TextField("Email", text: $email)
                                .frame(height: 40, alignment: .center)
                                .padding(.leading, 10)
                                .padding(.trailing, 10)
                                .font(.system(size: 15, weight: .regular, design: .default))
                                .imageScale(.small)
                                .keyboardType(.emailAddress)
                                .autocapitalization(UITextAutocapitalizationType.none)
                        }
                      
                        seperator()
                    }
                    
                    Spacer(minLength: 20)
                    
                    Button(action: {

                        if self.isValidInputs() {
                            sendPasswordReset(email: self.email)
                            //self.presentationMode.wrappedValue.dismiss()
                        }

                    }) {
                        
                        buttonWithBackground(btnText: "SUBMIT")
                    }
                    
                }
            }
        }.alert(isPresented: $showAlert, content: { self.alert })
    }
    
    func sendPasswordReset(email: String) {
        
        Auth.auth().languageCode = "ru"
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error as? NSError {
                switch AuthErrorCode(rawValue: error.code) {
                    case .userNotFound:
                        self.alertMsg = ResetMessage.userNotFound.rawValue
                        self.showAlert.toggle()
                    case .invalidEmail:
                        self.alertMsg = ResetMessage.invalidEmail.rawValue
                        self.showAlert.toggle()
                    case .invalidRecipientEmail:
                        self.alertMsg = ResetMessage.invalidRecipientEmail.rawValue
                        self.showAlert.toggle()
                    case .invalidSender:
                        self.alertMsg = ResetMessage.invalidSender.rawValue
                        self.showAlert.toggle()
                    case .invalidMessagePayload:
                        self.alertMsg = ResetMessage.invalidMessagePayload.rawValue
                        self.showAlert.toggle()
                    default:
                        print("Error message: \(error.localizedDescription)")
                }
            }
            else {
                self.alertMsg = ResetMessage.success.rawValue
                self.showAlert.toggle()
                print("Reset password email has been successfully sent")
            }
        }
        
    }
    
    func isValidInputs() -> Bool {
        
        if self.email == "" {
            self.alertMsg = "Email can't be blank."
            self.showAlert.toggle()
            return false
            
        } else if !self.email.isValidEmail {
            self.alertMsg = "Email is not valid."
            self.showAlert.toggle()
            return false
        }
        
        return true
    }
}

struct ModalView: View {
    
  var body: some View {
    Group {
      Text("Modal view")
      
    }
  }
}




extension String {
    
    var trim: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var isBlank: Bool {
        return self.trim.isEmpty
    }
    
    var isAlphanumeric: Bool {
        if self.count < 8 {
            return true
        }
        return !isBlank && rangeOfCharacter(from: .alphanumerics) != nil
//        let regex = "^[a-zA-Z0-9]$"
//        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
//        return predicate.evaluate(with:self)
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{2,4}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with:self)
    }
    
    var isValidPhoneNo: Bool {
        
        let phoneCharacters = CharacterSet(charactersIn: "+0123456789").inverted
        let arrCharacters = self.components(separatedBy: phoneCharacters)
        return self == arrCharacters.joined(separator: "")
    }
    
    var isValidPassword: Bool {
        let minPasswordLength = 6
        let passwordRegex = "^(?=.*[a-z])(?=.*[@$!%*#?&])[0-9a-zA-Z@$!%*#?&]{8,}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return predicate.evaluate(with:self) && self.count >= minPasswordLength
    }
    
    var isValidPhone: Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{4,15}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }
    
    var isValidURL: Bool {
        let urlRegEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: self)
    }
    
    var isValidBidValue: Bool {
        
        guard let doubleValue = Double(self) else { return false}
        if doubleValue < 0{
            return false
        }
        return true
    }
    
    var verifyURL: Bool {
        if let url  = URL(string: self) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
}

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
let lightGreenColor = Color(red: 21.0/255.0, green: 183.0/255.0, blue: 177.0/255.0, opacity: 1.0)
let lightblueColor = Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)) //Color(red: 85.0/255.0, green: 84.0/255.0, blue: 166.0/255.0, opacity: 1.0)

struct buttonWithBackground: View {
    
    var btnText: String
    
    var body: some View {
        
        HStack {
//            Spacer()
            Text(btnText)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 140, height: 50)
                .background(lightblueColor)
                .clipped()
                .cornerRadius(5.0)
                .shadow(color: lightblueColor, radius: 5, x: 0, y: 5)
            
//            Spacer()
        }
    }
}
