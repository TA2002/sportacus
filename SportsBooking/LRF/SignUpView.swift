//
//  SignUpView.swift
//  DemoSwiftUI
//
//  Created by mac-00018 on 10/10/19.
//  Copyright © 2019 mac-00018. All rights reserved.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    
    @EnvironmentObject var settings: UserSettings
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var contactNo: String = ""
    //@State var dob: String = ""
    @State var password = ""
    @State var confirmPassword = ""
    
    
    @State var alertMsg = ""
    @State var selection: Int = 1
    @State var integers: [String] = ["0", "1", "2", "3", "4", "5"]
    
    @State var date = Date()
    
    @State var showImagePicker: Bool = false
    @State var showCamera: Bool = false
    @State var image: Image? = nil
    
    @State var showAlert = false
    @State var showActionSheet: Bool = false
    
    @State var signupSelection: Int? = nil
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var birthDate = Date()
    
    var alert: Alert {
        Alert(title: Text(""), message: Text(alertMsg), dismissButton: .default(Text("OK")))
    }
    
    var body: some View {
        
//        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
        
        ScrollView {
            
            VStack {
                
                VStack {
                    
                    Spacer(minLength: 20)
                    
                    HStack {
                        
                        Image("ic_user")
                            .padding(.leading, 20)
                        
                        TextField("First Name", text: $firstName)
                            .frame(height: 40, alignment: .center)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .font(.system(size: 15, weight: .regular, design: .default))
                            .imageScale(.small)
                        
                        
                    }
                    seperator()
                }
                
                VStack {
                    
                    HStack {
                        
                        Image("ic_user")
                            .padding(.leading, 20)
                        
                        TextField("Last Name", text: $lastName)
                            .frame(height: 40, alignment: .center)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .font(.system(size: 15, weight: .regular, design: .default))
                            .imageScale(.small)
                        
                    }
                    seperator()
                }
                
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
                
                VStack {
                    
                    HStack {
                        
                        Image("ic_contactno")
                            .padding(.leading, 20)
                        
                        TextField("Contact No", text: $contactNo)
                            .frame(height: 40, alignment: .center)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .font(.system(size: 15, weight: .regular, design: .default))
                            .imageScale(.small)
                            .keyboardType(.numberPad)
                        
                    }
                    seperator()
                }
                
//                VStack {
//
//                    ZStack {
//                        HStack {
//
//                            Image("ic_dob")
//                                .padding(.leading, 20)
//
//                            TextField("Date of Birth", text: $dob)
//                                .frame(height: 40, alignment: .center)
//                                .padding(.leading, 10)
//                                .padding(.trailing, 10)
//                                .font(.system(size: 15, weight: .regular, design: .default))
//                                .imageScale(.small)
//
//                        }
//                    }
//                    seperator()
//                }
                
                VStack {
                    
                    HStack {
                        
                        Image("ic_password")
                            .padding(.leading, 20)
                        
                        SecureField("Password", text: $password)
                            .frame(height: 40, alignment: .center)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .font(.system(size: 15, weight: .regular, design: .default))
                            .imageScale(.small)
                        
                    }
                    seperator()
                }
                
                VStack {
                    
                    HStack {
                        
                        Image("ic_password")
                            .padding(.leading, 20)
                        
                        SecureField("Confirm Password", text: $confirmPassword)
                            .frame(height: 40, alignment: .center)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .font(.system(size: 15, weight: .regular, design: .default))
                            .imageScale(.small)
                        
                    }
                    seperator()
                }
                
               
                VStack {
                    
//                    VStack {
//
//                        NavigationLink(destination: LoginView(), tag: 1, selection: $signupSelection) {
//                            Button(action: {
//                                if  self.isValidInputs() {
//                                    print("Signup tapped")
//                                    self.signupSelection = 1
//                                }
//
//                            }) {
//                                HStack {
//                                    buttonWithBackground(btnText: "SUBMIT")
//                                }
//                            }
//
//                        }
//                    }
                 
                    Button(action: {
                        if self.isValidInputs() {
                            createUser(email, password)
//                            UserDefaults.standard.set(true, forKey: "Loggedin")
//                            UserDefaults.standard.synchronize()
//                            self.settings.loggedIn = true
                        }
                    }) {

                        buttonWithBackground(btnText: "Sign Up")
                    }
                    .padding(.bottom, (UIScreen.main.bounds.width * 30) / 414)
                    .alert(isPresented: $showAlert, content: { self.alert })
                }
            
            }
            
        }.navigationBarTitle("SignUp")
            .font(.system(size: 20, weight: .semibold, design: .default))
            .padding(.top, 40)
            .alert(isPresented: $showAlert, content: { self.alert })
    }
    
    private func createUser(_ userEmail: String, _ userPassword: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                    case .operationNotAllowed:
                        self.alertMsg = RegistrationMessage.operationNotAllowed.rawValue
                        self.showAlert.toggle()
                    case .emailAlreadyInUse:
                        self.alertMsg = RegistrationMessage.emailAlreadyInUse.rawValue
                        self.showAlert.toggle()
                    case .invalidEmail:
                        self.alertMsg = RegistrationMessage.invalidEmail.rawValue
                        self.showAlert.toggle()
                    case .weakPassword:
                        self.alertMsg = RegistrationMessage.weakPassword.rawValue
                        self.showAlert.toggle()
                    default:
                        print("Error: \(error.localizedDescription)")
                }
            }
            else {
                print("User signs up successfully")
                let newUserInfo = Auth.auth().currentUser
                let email = newUserInfo?.email
                self.alertMsg = RegistrationMessage.success.rawValue
                self.showAlert.toggle()
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    fileprivate func isValidInputs() -> Bool {
        
        if self.firstName == "" {
            self.alertMsg = "First name can't be blank."
            self.showAlert.toggle()
            return false
        } else if self.lastName == "" {
            self.alertMsg = "Last name can't be blank."
            self.showAlert.toggle()
            return false
        } else if self.email == "" {
            self.alertMsg = "Email can't be blank."
            self.showAlert.toggle()
            return false
        } else if !self.email.isValidEmail {
            self.alertMsg = "Email is not valid."
            self.showAlert.toggle()
            return false
        }  else if self.contactNo == "" {
            self.alertMsg = "Phone number can't be blank."
            self.showAlert.toggle()
            return false
//        } else if self.dob == "" {
//            self.alertMsg = "Date of birth can't be blank."
//            self.showAlert.toggle()
//            return false
//        }
        } else if self.password == "" {
            self.alertMsg = "Password can't be blank."
            self.showAlert.toggle()
            return false
        } else if !(self.password.isValidPassword) {
            self.alertMsg = "Please enter valid password"
            self.showAlert.toggle()
            return false
        } else if self.confirmPassword == "" {
            self.alertMsg = "Confirm password can't be blank."
            self.showAlert.toggle()
            return false
        } else if self.password != self.confirmPassword {
            self.alertMsg = "Password and confirm password dose not matched."
            self.showAlert.toggle()
            return false
        }
        
        return true
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

struct seperator: View {
    
    var body: some View {
    
        VStack {
            
            Divider().background(lightGreyColor)
            
        }.padding()
            .frame(height: 1, alignment: .center)
    }
}
