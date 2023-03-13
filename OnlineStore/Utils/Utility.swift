//
//  Utility.swift
//  OnlineStore
//
//  Created by dev on 3/12/23.
//

import Foundation
import Toast_Swift
import NVActivityIndicatorView

class Utility: NSObject {

    static var BASE_URL =  "https://dummyjson.com/"
    
    static var PRODUCT_LIST = BASE_URL + "products";
    
    static var activityIndicatorView : NVActivityIndicatorView? = nil
    

    //remove value from NSUSer Defaut
    class func showLoader(){
        
        var cfff = CGRect(x: 0, y: 0, width: UIScreen.screenWidth, height: UIScreen.screenHeight)
        
        activityIndicatorView = NVActivityIndicatorView( frame:cfff, type: .ballClipRotate, color: UIColor.black)
        activityIndicatorView?.startAnimating()
    }
    
    class func hideLoader(){
        activityIndicatorView?.stopAnimating()
    }
   
    class func showToast(view : UIView, message : String) {
        // create a new style
        var style = ToastStyle()
        
        // this is just one of many style options
        style.backgroundColor = .darkGray
        
        style.messageAlignment = .center
        
        if let font = UIFont(name: "Montserrat-Medium", size: 12.0) {
            style.messageFont = font
        }
        ToastManager.shared.style = style
        
        if let window = UIApplication.shared.keyWindow {
            window.makeToast(message)
        } else {
            view.makeToast(message)
        }
    }
    
    
    
}
