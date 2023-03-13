//
//  ProductDetailsView.swift
//  OnlineStore
//
//  Created by dev on 3/12/23.
//

import SwiftUI
import FiveStarRating
import CachedAsyncImage

struct ProductDetailsView: View {
    
    let productDet: Product?
    
    @State var imageGrid : [GridItem]
    
    var spaceHeight : CGFloat = 0
    
    @State private var index = 0

    
    func calculateProductMRP ( price : Int , discountPercentage : Double ) -> String {
        let realPrice = Double(price)
        var totalPercenage = 100 + discountPercentage // 549
        let disPrice = (((realPrice * totalPercenage ) / 100)).rounded()
        return String(disPrice)
    }
    
    struct CardView: View{
        var body: some View{
            Rectangle()
                .fill(Color.pink)
                .frame(height: 200)
                .border(Color.black)
                .padding()
        }
    }
    
    var body: some View {
        

        ScrollView (.vertical) {
            
            VStack (alignment : .leading) {
                
                VStack{
                            TabView(selection: $index) {
                                ForEach(0...(productDet?.images?.count ?? 0) - 1, id: \.self) { index in
                                    
                                    CachedAsyncImage(
                                        url: URL(string: productDet?.images?[index] ?? ""),
                                        //transaction: .init(animation: .easeInOut),
                                        content: { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                        }, placeholder: {
                                            ProgressView()
                                        }).frame(width: UIScreen.screenWidth, height: 200)
                                }
                            }
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                        }
                        .frame(height: 200)
                
                
                VStack (alignment : .leading, spacing: CGFloat(16)) {
                    
                    Group {
                        
                        
                        HStack (alignment : .top) {
                            VStack  (alignment : .leading) {
                                Text("Product").fontWeight(Font.Weight.bold).foregroundColor(Color.black)
                                Text(productDet?.title ?? "").foregroundColor(Color.black)
                            }
                            Spacer()
                            VStack (alignment : .trailing){
                                Text("Price").fontWeight(Font.Weight.bold).foregroundColor(Color.black)
                                HStack {
                                    Text(String(productDet?.price ?? 0)).foregroundColor(Color.blue)
                                    Text(
                                        calculateProductMRP(price: productDet?.price ?? 0, discountPercentage: productDet?.discountPercentage ?? 0.0)
                                    ).foregroundColor(Color.blue).strikethrough()
                                    Text(String(productDet?.discountPercentage ?? 0.0))
                                        .fontWeight(Font.Weight.bold)
                                        .foregroundColor(Color.gray.opacity(0.7))
                                        .padding(.leading,10)
                                        .padding(.trailing,10)
                                        .padding(.top,5)
                                        .padding(.bottom,5)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 22)
                                                .stroke(.blue, lineWidth: 1)
                                        )
                                    
                                }
                            }
                        }
                        
                        
                        Text("Category").fontWeight(Font.Weight.bold).foregroundColor(Color.black)
                        Text(productDet?.title ?? "").foregroundColor(Color.black)
                        
                      
                        
                
                    }
                        
                    Group {
                        
                        Spacer().frame(height: spaceHeight)
                        
                        Text("Brand").fontWeight(Font.Weight.bold).foregroundColor(Color.black)
                        Text(productDet?.brand ?? "").foregroundColor(Color.black)
                        
                        
                    }
                    
                    Group {
                        Spacer().frame(height: spaceHeight)
                        
                        Text("Stock").fontWeight(Font.Weight.bold).foregroundColor(Color.black)
                        Text(String(productDet?.stock ?? 0))
                    }
                    
                    Group {
                        
                        Spacer().frame(height: spaceHeight)
                        
                        Text("Rating").fontWeight(Font.Weight.bold).foregroundColor(Color.black)
                        HStack {
                            Text(String(productDet?.rating ?? 0.0)).foregroundColor(Color.gray.opacity(0.7))
                            FiveStarView(rating: Decimal(productDet?.rating ?? 0.0), color : Color.orange, backgroundColor: Color.orange.opacity(0.2)).frame(minWidth: 0, idealWidth: 30, maxWidth: 30, minHeight: 1, idealHeight: 20, maxHeight: 20, alignment: .leading)
                            
                        }
                        
                        Spacer().frame(height: spaceHeight)
                        
                        Text("Product Description").fontWeight(Font.Weight.bold).foregroundColor(Color.black)
                        Text(productDet?.description ?? "")
                    }
                    
                }.padding(.trailing, 16).padding(.leading, 16).padding(.top , 16)
                
                Spacer()
                
            }
        }
    
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView(productDet: nil, imageGrid: [])
    }
}
