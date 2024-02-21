//
//  MainPage.swift
//  YogaShop
//
//  Created by Yoga Adi Pratama on 30/01/24.
//

import SwiftUI

struct MainPage: View {
    // Current Tab...
    @State var currentTab: Tab = .Home
    
    @StateObject var sharedData: SharedDataModel = SharedDataModel()
    
    // Animation Namespace...
    @Namespace var animation
    
    // Hiding Tab Bar...
    init(){
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        
        VStack(spacing: 0){
            
            // Tab View
            TabView(selection: $currentTab) {
                
                Home(animation: animation)
                    .environmentObject(sharedData)
                    .tag(Tab.Home)
                
                LikedPage()
                    .environmentObject(sharedData)
                    .tag(Tab.Liked)
                
                ProfilePage()
                    .tag(Tab.Profile)
                
                CartPage()
                    .environmentObject(sharedData)
                    .tag(Tab.Cart)
            }
            
            // Custom Tab Bar...
            HStack(spacing: 0){
                ForEach(Tab.allCases, id: \.self){tab in
                    
                    Button {
                        // Updating Tab...
                        currentTab = tab
                    } label: {
                        
                        Image(tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 27, height: 27)
                        // Applying Little Shadow At Bg...
                            .background(
                                Color.purple
                                    .opacity(0.1)
                                    .cornerRadius(15)
                                // Bluring...
                                    .blur(radius: 5)
                                // Making Little Big...
                                    .padding(-5)
                                    .opacity(currentTab == tab ? 1 : 0)
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? Color.purple : Color.black.opacity(0.3))
                    }
                }
            }
            .padding([.horizontal, .top])
            .padding(.bottom, 10)
        }
        .background(Color.white.ignoresSafeArea())
        .overlay(
            
            ZStack{
                // Detail Page...
                if let product = sharedData.detailProduct, sharedData.showDetailProduct{
                    
                    ProductDetailView(product: product, animation: animation)
                        .environmentObject(sharedData)
                    // Adding Transitions...
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                }
            }
        )
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

// Making Case Iterable...
// Tab Cases...
enum Tab: String, CaseIterable{
    
    // Raw Value must be image Name in asset...
    case Home = "Home"
    case Liked = "Liked"
    case Profile = "Profile"
    case Cart = "Cart"
}
