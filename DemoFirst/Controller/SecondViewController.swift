//
//  SecondViewController.swift
//  DemoFirst
//
//  Created by chanda on 13/08/20.
//  Copyright © 2020 chanda. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
   
 //MARK: Stored Properties
// var instaa  = StoryBorViewController()
  var instaa = ImageAPI()
  var amii:DemoAPI?
  var imgs:UIImage?
  var a:String?
  var name:String!
    
//MARK: Outlets
    @IBOutlet weak var authLabel: UILabel!
    @IBOutlet weak var secondImg: UIImageView!
    
//MARK: ViewDidLoad
    
override func viewDidLoad() {
    super.viewDidLoad()
     view.backgroundColor = .black
       fetchingDta()
    }
    
//MARK: Navigation Data
    func fetchingDta(){
        if let url = URL(string: a!){
                  imgs = instaa.fecthes(from: url)
                      secondImg.image = imgs
                    
    }
        authLabel.text = name
    }
    
    
}
    

