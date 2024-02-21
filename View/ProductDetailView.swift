//
//  ProductDetailView.swift
//  YogaShop
//
//  Created by Yoga Adi Pratama on 01/02/24.
//

import SwiftUI

struct ProductDetailView: View {
    var product: Product
    
    // For Matched Geometry Effect...
    var animation: Namespace.ID
    
    // Shared Data Model...
    @EnvironmentObject var sharedData: SharedDataModel
    
    @EnvironmentObject var homeData: HomeViewModel
    
    var body: some View {
        
        VStack{
            
            // Title Bar and Product Image...
            VStack{
                
                // Title Bar...
                HStack{
                    
                    Button {
                        // Closing View...
                        withAnimation(.easeInOut){
                            sharedData.showDetailProduct = false
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                    
                    Spacer()
                    
                    Button {
                        addToLiked()
                    } label: {
                        Image("Liked")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .foregroundColor(isLiked() ? .red :
                                Color.black.opacity(0.7))
                    }
                }
                .padding()
                
                // Product Image...
                // Adding Matched Geometry Effect...
                Image(product.productImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "\(product.id)\(sharedData.fromSearchPage ? "SEARCH" : "IMAGE")", in: animation)
                    .padding(.horizontal)
                    .offset(y: -12)
                    .frame(maxHeight: .infinity)
            }
            .frame(height: getRect().height / 2.7)
            .zIndex(1)
            
            // Product Details...
            ScrollView(.vertical, showsIndicators: false) {
                
                // Product Data...
                VStack(alignment: .leading, spacing: 15) {
                    
                    Text(product.title)
                        .font(.custom(customFont, size: 20).bold())
                    
                    Text(product.subtitle)
                        .font(.custom(customFont, size: 18))
                        .foregroundColor(.gray)
                    
                    Text("Dapatkan Motor, Helm, Sparepart dan juga Aksesories motor di YogaPratama MotorShop")
                        .font(.custom(customFont, size: 16).bold())
                        .padding(.top)
                    
                    Text("Dapatkan harga terbaru di tahun 2024 untuk setiap pembelian produk pada toko kami, terdapat promo spesial di awal tahun 2024 dan tersedia berbagai produk yang berkualitas bagus yang kami jual.")
                        .font(.custom(customFont, size: 15))
                        .foregroundColor(.gray)
                    
                    Button {
                        
                    } label: {
                        
                        // Since we need image at right...
                        Label {
                            Image(systemName: "arrow.right")
                        } icon: {
                            Text("Full Deskripsi")
                        }
                        .font(.custom(customFont, size: 15).bold())
                        .foregroundColor(Color.purple)
                    }
                    
                    HStack{
                        
                        Text("Total")
                            .font(.custom(customFont, size: 17))
                        
                        Spacer()
                        
                        Text("\(product.price)")
                            .font(.custom(customFont, size: 20).bold())
                            .foregroundColor(Color.purple)
                    }
                    .padding(.vertical, 20)
                    
                    // Add button...
                    Button {
                        addToCart()
                    } label: {
                        Text("\(isAddedToCart() ? "Ditambah" : "Tambah") ke Keranjang")
                            .font(.custom(customFont, size: 20).bold())
                            .foregroundColor(.white)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .background(
                            
                                Color.purple
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                            )
                    }
                }
                .padding([.horizontal, .bottom], 20)
                .padding(.top, 25)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                // Corner Radius for only top side...
                    .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
                    .ignoresSafeArea()
            )
            .zIndex(0)
        }
        .animation(.easeInOut, value: sharedData.likedProducts)
        .animation(.easeInOut, value: sharedData.cartProducts)
        .background(Color.gray.ignoresSafeArea())
    }
    
    func isLiked()->Bool{
        
        return sharedData.likedProducts.contains { product in
            return self.product.id == product.id
        }
    }
    
    func isAddedToCart()->Bool{
        
        return sharedData.cartProducts.contains { product in
            return self.product.id == product.id
        }
    }
    
    func addToLiked(){
        
        if let index = sharedData.likedProducts.firstIndex(where: { product in return self.product.id == product.id
        }){
            // Remove from liked...
            sharedData.likedProducts.remove(at: index)
        }
        else{
            // Add to liked...
            sharedData.likedProducts.append(product)
        }
    }
    func addToCart(){
        
        if let index = sharedData.cartProducts.firstIndex(where: { product in return self.product.id == product.id
        }){
            // Remove from liked...
            sharedData.cartProducts.remove(at: index)
        }
        else{
            // Add to liked...
            sharedData.cartProducts.append(product)
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Sample Product for Building Preview...
//        ProductDetailView(product: HomeViewModel().products[0]).environmentObject(SharedDataModel())
        
        MainPage()
    }
}
