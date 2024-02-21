//
//  SearchView.swift
//  YogaShop
//
//  Created by Yoga Adi Pratama on 31/01/24.
//

import SwiftUI

struct SearchView: View {
    var animation: Namespace.ID
    
    // Shared Data...
    @EnvironmentObject var sharedData: SharedDataModel
    
    @EnvironmentObject var homeData: HomeViewModel
    
    // Activating Text Field with the help of FocusState...
    @FocusState var startTF: Bool
    
    var body: some View {
        
        VStack(spacing: 0){
            
            // Search Bar...
            HStack(spacing: 20){
                
                // Close Button...
                Button {
                    withAnimation {
                        homeData.searchActivated = false
                    }
                    homeData.searchText = ""
                    // Resetting...
                    sharedData.fromSearchPage = false
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(Color.black.opacity(0.7))
                }

                // Search Bar...
                HStack(spacing: 15){
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    // Since We Need a Separate View For Search Bar...
                    TextField("Search", text: $homeData.searchText)
                        .focused($startTF)
                        .textCase(.lowercase)
                        .disableAutocorrection(true)
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(
                
                    Capsule()
                        .strokeBorder(Color.purple, lineWidth: 1.5)
                )
                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing, 20)
            }
            .padding([.horizontal])
            .padding(.top)
            .padding(.bottom, 10)
            
            // Showing Progress if searching...
            // else showing no results found if empty...
            if let products = homeData.searchedProducts{
                
                if products.isEmpty{
                    
                    // No Results Found...
                    VStack(spacing: 10){
                        
                        Image("NotFound")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.top, 60)
                        
                        Text("Barang tidak ditemukan")
                            .font(.custom(customFont, size: 22).bold())
                        
                        Text("Coba istilah pencarian yang lebih umum atau coba cari produk alternatif.")
                            .font(.custom(customFont, size: 16))
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                    }
                    .padding()
                }
                else{
                    // Filter Results...
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        VStack(spacing: 0){
                            
                            // Found Text...
                            Text("Temukan \(products.count) hasil")
                                .font(.custom(customFont, size: 24).bold())
                                .padding(.vertical)
                            
                            // Staggered Grid...
                            // See my Staggered Video...
                            // Link in Bio...
                            StaggeredGrid(columns: 2, spacing: 20, list: products) {product in
                                
                                // Card View...
                                ProductCardView(product: product)
                            }
                        }
                        .padding()
                    }
                }
                
            }
            else{
                
                ProgressView()
                    .padding(.top, 30)
                    .opacity(homeData.searchText == "" ? 0 : 1)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.white.ignoresSafeArea())
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                startTF = true
            }
        }
    }
    
    @ViewBuilder
    func ProductCardView(product: Product)->some View{
        
        VStack(spacing: 10){
            
            ZStack{
                
                if sharedData.showDetailProduct{
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0)
                }
                else{
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "\(product.id)SEARCH", in: animation)
                }
            }
            // Moving image To Top To Look Like Its Fixed At Half Top...
            .offset(y: -50)
            .padding(.bottom, -50)
            
            Text(product.title)
                .font(.custom(customFont, size: 18))
                .fontWeight(.semibold)
                .padding(.top, 5)
            
            Text(product.subtitle)
                .font(.custom(customFont, size: 14))
                .foregroundColor(.gray)
            
            Text(product.price)
                .font(.custom(customFont, size: 16))
                .fontWeight(.bold)
                .foregroundColor(Color.purple)
                .padding(.top, 5)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 22)
        .background(
            Color.yellow
                .cornerRadius(25)
        )
        .padding(.top, 50)
        .onTapGesture {
            
            withAnimation(.easeInOut){
                sharedData.fromSearchPage = true
                sharedData.detailProduct = product
                sharedData.showDetailProduct = true
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        
        MainPage()
    }
}
