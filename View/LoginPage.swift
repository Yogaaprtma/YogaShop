//
//  LoginPage.swift
//  YogaShop
//
//  Created by Yoga Adi Pratama on 30/01/24.
//

import SwiftUI

struct LoginPage: View {
    @StateObject var loginData: LoginPageModel = LoginPageModel()

    var body: some View {
        NavigationView {
            VStack {
                // Welcome Back text for 3 half of the screen...
                Text("Welcome\nBack")
                    .font(.custom(customFont, size: 55).bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: getRect().height / 3.5)
                    .padding()
                    .background(
                        ZStack {
                            // Gradient Circle...
                            LinearGradient(colors: [
                                Color("loginCircle"),
                                Color("LoginCircle").opacity(0.8),
                                Color.purple
                            ], startPoint: .top, endPoint: .bottom)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                            .padding(.trailing)
                            .offset(y: -25)
                            .ignoresSafeArea()
                            
                            Circle()
                                .strokeBorder(Color.white.opacity(0.8), lineWidth: 3)
                                .frame(width: 30, height: 30)
                                .blur(radius: 2)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                                .padding(30)
                            
                            Circle()
                                .strokeBorder(Color.white.opacity(0.8), lineWidth: 3)
                                .frame(width: 23, height: 23)
                                .blur(radius: 2)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .padding(.leading,30)
                        }
                    )
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 15) {
                        // Toggle Register or Login text...
                        Text(loginData.registerUser ? "Register" : "Login")
                            .font(.custom(customFont, size: 22).bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Custom Text Field for Email...
                        CustomTextField(icon: "envelope", title: "Email", hint: "yogaadipratama@gmail.com", value: $loginData.email, showPassword: .constant(false))
                            .padding(.top, 30)
                        
                        // Custom Text Field for Password...
                        CustomTextField(icon: "lock", title: "Password", hint: "12345", value: $loginData.password, showPassword: $loginData.showPassword)
                            .padding(.top, 10)
                        
                        // Register ReEnter Password
                        if loginData.registerUser {
                            CustomTextField(icon: "envelope", title: "Re-Enter Password", hint: "12345", value: $loginData.re_Enter_Password, showPassword: $loginData.showReEnterPassword)
                                .padding(.top, 10)
                        }
                        
                        // Forgot Password Button...
                        Button {
                            loginData.ForgetPassword()
                        } label: {
                            Text("Lupa Password?")
                                .font(.custom(customFont, size: 14))
                                .fontWeight(.semibold)
                                .foregroundColor(Color.purple)
                        }
                        .padding(.top, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Login Button...
                        NavigationLink(
                            destination: MainPage(),
                            isActive: $loginData.log_Status,
                            label: {
                                Button {
                                    if loginData.registerUser {
                                        loginData.Register()
                                    } else {
                                        loginData.Login()
                                    }
                                } label: {
                                    Text("Login")
                                        .font(.custom(customFont, size: 17).bold())
                                        .padding(.vertical, 20)
                                        .frame(maxWidth: .infinity)
                                        .foregroundColor(.white)
                                        .background(Color.purple)
                                        .cornerRadius(15)
                                        .shadow(color: Color.black.opacity(0.07), radius: 5, x: 5, y: 5)
                                }
                            }
                        )
                        .padding(.top, 25)
                        .padding(.horizontal)
                        
                        // Register User Button...
                        Button {
                            withAnimation {
                                loginData.registerUser.toggle()
                            }
                        } label: {
                            Text(loginData.registerUser ? "Kembali Ke Login" : "Buat Akun")
                                .font(.custom(customFont, size: 14))
                                .fontWeight(.semibold)
                                .foregroundColor(Color.purple)
                        }
                        .padding(.top, 8)
                    }
                    .padding(30)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Color.white
                    .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
                    .ignoresSafeArea()
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.yellow)
            // Clearing Data When Changes...
            // Optional...
            .onChange(of: loginData.registerUser) { newValue in
                loginData.email = ""
                loginData.password = ""
                loginData.re_Enter_Password = ""
                loginData.showPassword = false
                loginData.showReEnterPassword = false
            }
            .navigationTitle("") // Sembunyikan judul navigasi
            .navigationBarHidden(true) // Sembunyikan bilah navigasi
        }
    }

    @ViewBuilder
    func CustomTextField(icon: String, title: String, hint: String, value: Binding<String>, showPassword: Binding<Bool>)->some View{
        
        VStack(alignment: .leading, spacing: 12) {
            
            Label{
                Text(title)
                    .font(.custom(customFont, size: 14))
            } icon: {
                Image(systemName: icon)
            }
            .foregroundColor(Color.black.opacity(0.8))
            
            if title.contains("Password") && !showPassword.wrappedValue{
                SecureField(hint, text: value)
                    .padding(.top, 2)
            }
            else{
                TextField(hint, text: value)
                    .padding(.top, 2)
            }
            
            Divider()
                .background(Color.black.opacity(0.4))
        }
        // Showing Show Button For Password Field...
        .overlay(
            
            Group{
                
                if title.contains("Password"){
                    Button(action: {
                        showPassword.wrappedValue.toggle()
                    }, label: {
                        Text(showPassword.wrappedValue ? "Hide" : "Show")
                            .font(.custom(customFont, size: 13).bold())
                            .foregroundColor(Color.purple)
                    })
                    .offset(y: 8)
                }
            }
            ,alignment: .trailing
        )
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
