//
//  SplashScreen.swift
//  DemoFirst
//
//  Created by chanda on 14/08/20.
//  Copyright © 2020 chanda. All rights reserved.
//

import UIKit

class SplashScreen{
    
    let arImage = UIImageView(image: UIImage(named: "clock 2")!)
         let splashView = UIView()
        
    func splashConstraints(width:CGFloat,height:CGFloat){
            splashView.backgroundColor = UIColor(red:75/256, green:0/256,blue:130/256,alpha: 1.0)
                      //  view.addSubview(splashView)
                        splashView.frame = CGRect(x: 0, y: 0, width:width, height:height)
                        arImage.contentMode = .scaleAspectFit
                        splashView.addSubview(arImage)
                        arImage.frame = CGRect(x: splashView.frame.midX - 50, y: splashView.frame.midY-50, width: 100, height: 100)
        }
        func scaleDownAnimation(){
            UIView.animate(withDuration: 0.5, animations: {
                self.arImage.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }) {(success) in
                
                self.scaleUpAnimation()
            }
        }
        func scaleUpAnimation(){
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                self.arImage.transform = CGAffineTransform(scaleX: 5, y: 5)
            }) { (success) in
                self.removeSplashScreen()
            }
            
        }
        
        func removeSplashScreen(){
            
            splashView.removeFromSuperview()
        }
        

    
}
  
