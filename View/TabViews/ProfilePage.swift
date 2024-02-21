//
//  ProfilePage.swift
//  YogaShop
//
//  Created by Yoga Adi Pratama on 31/01/24.
//

import SwiftUI

struct ProfilePage: View {
    var body: some View {
        
        NavigationView{
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack{
                    
                    Text("My Profile")
                        .font(.custom(customFont, size: 28))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(spacing: 15){
                        
                        Image("Profile_Image")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .offset(y: -30)
                            .padding(.bottom, -30)
                        
                        Text("Yoga Adi Pratama")
                            .font(.custom(customFont, size: 16))
                            .fontWeight(.semibold)
                        
                        HStack(alignment: .top, spacing: 10) {
                            
                            Image(systemName:
                                "location.north.circle.fill")
                                .foregroundColor(.gray)
                                .rotationEffect(.init(degrees: 180))
                            
                            Text("Alamat: Desa Trangkil Pati\nJateng, Indonesia")
                                .font(.custom(customFont, size: 15))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding([.horizontal, .bottom])
                    .background(
                    
                        Color.yellow
                            .cornerRadius(12)
                    )
                    .padding()
                    .padding(.top, 40)
                    
                    // Custom Navigation Links...
                    
                    CustomNavigationLink(title: "Edit Profile") {
                        
                        Text("")
                            .navigationTitle("Edit Profile")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.white.ignoresSafeArea())
                    }
                    
                    CustomNavigationLink(title: "Shopping Address") {
                        
                        Text("")
                            .navigationTitle("Shopping Address")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.white.ignoresSafeArea())
                    }
                    
                    CustomNavigationLink(title: "Order History") {
                        
                        Text("")
                            .navigationTitle("Order History")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.white.ignoresSafeArea())
                    }
                    
                    CustomNavigationLink(title: "Cards") {
                        
                        Text("")
                            .navigationTitle("Cards")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.white.ignoresSafeArea())
                    }
                    
                    CustomNavigationLink(title: "Notifications") {
                        
                        Text("")
                            .navigationTitle("Notifications")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.white.ignoresSafeArea())
                    }
                }
                .padding(.horizontal, 22)
                .padding(.vertical, 20)
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white.ignoresSafeArea())
        }
    }
    
    // Avoiding new Structs...
    @ViewBuilder
    func CustomNavigationLink<Detail: View>(title: String, @ViewBuilder content: @escaping ()->Detail)->some View{
        
        NavigationLink {
            content()
        } label: {
            
            HStack{
                
                Text(title)
                    .font(.custom(customFont, size: 17))
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            .foregroundColor(.black)
            .padding()
            .background(
            
                Color.yellow
                    .cornerRadius(12)
            )
            .padding(.horizontal)
            .padding(.top, 10)
        }
        
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
