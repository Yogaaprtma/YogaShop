//
//  ContentView.swift
//  YogaShop
//
//  Created by Yoga Adi Pratama on 30/01/24.
//

import SwiftUI

struct ContentView: View {
    // Log Status...
    @AppStorage("log_Status") var log_Status: Bool = false
    var body: some View {
        Group{
            if log_Status{
                MainPage()
            }
            else{
                OnBoardingPage()
            }
        }
        .onAppear{
            log_Status = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
