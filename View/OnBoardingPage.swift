//
//  OnBoardingPage.swift
//  YogaShop
//
//  Created by Yoga Adi Pratama on 30/01/24.
//

import SwiftUI

// Untuk Menggunakan font khusus di semua halaman..
let customFont = "Raleway-Bold"

struct OnBoardingPage: View {
    // Showing Login Page...
    @State var showLoginPage: Bool = false
    var body: some View {
        
        VStack(alignment: .leading){
            
            Text("Yoga Pratama")
                .font(.custom(customFont, size: 40))
                .foregroundColor(.white)
                .padding(.leading, 20)
            Text("Motor Store")
                .font(.custom(customFont, size: 40))
                .foregroundColor(.blue)
                .padding(.leading, 20)
            
            // Karena kami menambahkan ketiga font di Info.plist
            // Kita dapat memanggil semua font itu dengan nama apa saja...
            Image("Logo")
                .aspectRatio(contentMode: .fit)
            
            Button {
                withAnimation{
                    showLoginPage = true
                }
            } label: {
                
                Text("Ayo Mulai")
                    .font(.custom(customFont, size: 18))
                    .fontWeight(.semibold)
                    .padding(.vertical,18)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                    .foregroundColor(Color.cyan)
            }
            .padding(.horizontal,30)
            // Adding Some Adjustments only for larger displays...
            .offset(y: getRect().height < 750 ? 20 : 40)
            
            Spacer()
            
        }
        .padding()
        .padding(.top,getRect().height < 750 ? 20 : 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow)
        .overlay(
        
            Group{
                if showLoginPage{
                    LoginPage()
                        .transition(.move(edge: .bottom))
                }
            }
        )
    }
}

struct OnBoardingPage_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingPage()
    }
}

// Extending View to get Screen Sounds..
extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}
