//
//  ContentView.swift
//  OnlineStore
//
//  Created by dev on 3/12/23.
//

import SwiftUI
import Alamofire
import FiveStarRating
import CachedAsyncImage

struct HomeView: View {
    
    @State var productsList: [Product]
    
    func calculateProductMRP ( price : Int , discountPercentage : Double ) -> String {
        let realPrice = Double(price)
        var totalPercenage = 100 + discountPercentage // 549
        let disPrice = (((realPrice * totalPercenage ) / 100)).rounded()
        return String(disPrice)
    }
    
    var body: some View {
        
        NavigationView {
            
            ListIndexed( $productsList ) { index, $product in
                
                
                var rat : CGFloat = product.rating ?? 0.0
               
                NavigationLink(destination: ProductDetailsView(productDet: product, imageGrid: [])) {
                    HStack (alignment: .top,spacing: 20)  {
                        CachedAsyncImage(
                            url: URL(string: product.thumbnail ?? ""),
                            //transaction: .init(animation: .easeInOut),
                            content: { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            }, placeholder: {
                               // Color.gray.opacity(0.5)
                                ProgressView()
                            }).frame(width: 100, height: 100).mask(RoundedRectangle(cornerRadius: 16))
                        
                        VStack (alignment: .leading, spacing: 10) {
                            Text(product.title ?? "").fontWeight(Font.Weight.bold).foregroundColor(Color.black)
//                            Text(product.description ?? "")
                            HStack (spacing : 5) {
                                Text(String(product.price ?? 0)).fontWeight(Font.Weight.bold).foregroundColor(Color.blue)
                                Text(
                                    calculateProductMRP(price: product.price ?? 0, discountPercentage: product.discountPercentage ?? 0.0)
                                ).fontWeight(Font.Weight.bold).foregroundColor(Color.blue).strikethrough()
                            }
                            
//                            StarRatingView(rating:  4.69)
//                                .frame(width: 300, height: 30)
                           
//                            AxisRatingBar(value: value2[index], constant: constant1) {
//                                /// A view builder for background views.
//                                ARStar(count: 5, innerRatio: 1)
//                                    .fill(Color.orange.opacity(0.2))
//                            } foreground: {
//                                /// A view builder for foreground views.
//                                ARStar(count: 5, innerRatio: 1)
//                                    .fill(Color.orange)
//                            }
                            
                            FiveStarView(rating: Decimal(product.rating ?? 0.0), color : Color.orange, backgroundColor: Color.orange.opacity(0.2)).frame(minWidth: 0, idealWidth: 30, maxWidth: 30, minHeight: 1, idealHeight: 20, maxHeight: 20, alignment: .leading)
                            
                        }
                    }
                    
                }.onAppear() {
                    ///updateRating(rat: rat);
                    
                }
               
//
//                Text(product.title ?? "")
//                Text(product.title ?? "")
//                Text(product.title ?? "")
                
                
            }.onAppear() {
                getProductData()
            }
        }.navigationTitle("Products")
    }
    
    func getProductData() {

        Utility.showLoader()
        
        APIService().sendRequest( requestMethod: .get, forUrl: Utility.PRODUCT_LIST, parameters: [:]) { result in
            do {
                let model = try JSONDecoder().decode(ProductModel.self, from: result)
                productsList = model.products
            } catch {
                //Utility.showToast(view: <#T##UIView#>, message: error.localizedDescription)
                print("Model issue -> ", error.localizedDescription);
                print("Model issue 2 -> ", error);
                print("Model issue 3 -> ", error.asAFError);
                print("Model issue 4 -> ", error.self);
            }
            return result
        }
        
        
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(productsList: [])
    }
}

struct ListIndexed<Content: View>: View {
    let list: List<Never, Content>
    
    init<Data: MutableCollection&RandomAccessCollection, RowContent: View>(
        _ data: Binding<Data>,
        @ViewBuilder rowContent: @escaping (Data.Index, Binding<Data.Element>) -> RowContent
    ) where Content == ForEach<[(Data.Index, Data.Element)], Data.Element.ID, RowContent>,
    Data.Element : Identifiable,
    Data.Index : Hashable
    {
        list = List {
            ForEach(
                Array(zip(data.wrappedValue.indices, data.wrappedValue)),
                id: \.1.id
            ) { i, _ in
                rowContent(i, Binding(get: { data.wrappedValue[i] }, set: { data.wrappedValue[i] = $0 }))
            }
        }
    }
    
    var body: some View {
        list
    }
}
