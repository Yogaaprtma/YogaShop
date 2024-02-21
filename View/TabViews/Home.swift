//
//  Home.swift
//  YogaShop
//
//  Created by Yoga Adi Pratama on 30/01/24.
//

import SwiftUI

struct Home: View {
    var animation: Namespace.ID
    
    // Shared Data...
    @EnvironmentObject var sharedData: SharedDataModel
    
    @StateObject var homeData: HomeViewModel = HomeViewModel()
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing: 15){
                
                // Search Bar...
                
                ZStack{
                    
                    if homeData.searchActivated{
                        SearchBar()
                    }
                    else{
                        SearchBar()
                            .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                    }
                }
                .frame(width: getRect().width / 1.6)
                .padding(.horizontal, 25)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut){
                        homeData.searchActivated = true
                    }
                }
                
                Text("Pesan Online\nDapatkan di Toko")
                    .font(.custom(customFont, size: 28).bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal, 25)
                
                // Products Tab...
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 18){
                        
                        ForEach(ProductType.allCases, id: \.self){type in
                            
                            // Product Type View...
                            ProductTypeView(type: type)
                            
                        }
                    }
                    .padding(.horizontal, 25)
                }
                .padding(.top, 28)
                
                // Product Page...
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 25){
                        
                        ForEach(homeData.filteredProducts){product in
                            
                            // Product Card View...
                            ProductCardView(product: product)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.bottom)
                    .padding(.top, 80)
                }
                .padding(.top, 30)
                
                // See More Button...
                // This Button Will Show All products On The Current Product Type...
                // Since Here Were Showing Only 6...
                
                Button {
                    homeData.showMoreProductsOnType.toggle()
                } label: {
                    
                    // Since We Need Image Ar Right...
                    Label {
                        Image(systemName: "arrow.right")
                    } icon: {
                        Text("See More")
                    }
                    .font(.custom(customFont, size: 15).bold())
                    .foregroundColor(Color.purple)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing)
                .padding(.top, 10)
            }
            .padding(.vertical)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        // Updating Data Whenever Tab Changes...
        .onChange(of: homeData.productType) { newValue in
            homeData.filterProductByType()
        }
        // Preview Issue...
        .sheet(isPresented: $homeData.showMoreProductsOnType) {
            
        } content: {
            MoreProductsView()
        }
        // Displaying Search View...
        .overlay(
        
            ZStack{
                
                if homeData.searchActivated{
                    SearchView(animation: animation)
                        .environmentObject(homeData)
                }
            }
        )
    }
    
    // Since we're adding matched geometry effect...
    // Avoiding code replication...
    @ViewBuilder
    func SearchBar()->some View{
        
        HStack(spacing: 15){
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .foregroundColor(.gray)
            
            // Since We Need a Separate View For Search Bar...
            TextField("Search", text: .constant(""))
                .disabled(true)
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(
        
            Capsule()
                .strokeBorder(Color.gray, lineWidth: 0.8)
        )
    }
    
    @ViewBuilder
    func ProductCardView(product: Product)->some View{
        
        VStack(spacing: 10){
            
            // Adding Matched Geometry Effect...
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
                        .matchedGeometryEffect(id: "\(product.id)IMAGE", in: animation)
                }
            }
            .frame(width: getRect().width / 2.5, height: getRect().width / 2.5)
        // Moving image To Top To Look Like Its Fixed At Half Top...
            .offset(y: -80)
            .padding(.bottom, -80)
            
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
        // Showing Product detail when tapped...
        .onTapGesture {
            
            withAnimation(.easeInOut){
                sharedData.detailProduct = product
                sharedData.showDetailProduct = true
            }
        }
    }
    
    @ViewBuilder
    func ProductTypeView(type: ProductType)->some View{
        
        Button {
            // Updating Current Type...
            withAnimation{
                homeData.productType = type
            }
        } label: {
            
            Text(type.rawValue)
                .font(.custom(customFont, size: 15))
                .fontWeight(.semibold)
            // Changing Color Based On Current Product Type...
                .foregroundColor(homeData.productType == type ? Color.purple : Color.gray)
                .padding(.bottom, 10)
            // Adding Indicator At Bottom...
                .overlay(
                
                    // Adding Matched Geometry Effect...
                    ZStack{
                        if homeData.productType == type{
                            Capsule()
                                .fill(Color.purple)
                                .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
                                .frame(height: 2)
                        }
                        else{
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 2)
                        }
                    }
                    .padding(.horizontal, -5)
                    
                    ,alignment: .bottom
                )
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
