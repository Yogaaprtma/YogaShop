//
//  LoginPageModel.swift
//  YogaShop
//
//  Created by Yoga Adi Pratama on 30/01/24.
//

import SwiftUI

class LoginPageModel: ObservableObject {
    
    // Login Properties..
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    
    // Register Properties..
    @Published var registerUser: Bool = false
    @Published var re_Enter_Password: String = ""
    @Published var showReEnterPassword: Bool = false
    
    // Log Status...
    @AppStorage("log_Status") var log_Status: Bool = false
    
    // Login Call...
    func Login(){
        // Do Action Here...
        withAnimation {
            log_Status = true
        }
    }
    
    func Register(){
    // Do Action Here...
        withAnimation {
            log_Status = true
        }
    }
    
    func ForgetPassword(){
    // Do Action Here...
    }
}
