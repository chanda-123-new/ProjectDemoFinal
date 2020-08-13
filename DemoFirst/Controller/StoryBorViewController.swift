//
//  StoryBorViewController.swift
//  DemoFirst
//
//  Created by chanda on 13/08/20.
//  Copyright © 2020 chanda. All rights reserved.
//

import UIKit

let imagCache = NSCache<AnyObject, AnyObject>()

class StoryBorViewController: UIViewController {

    
//MARK: Outlets
    @IBOutlet weak var tblView: UITableView!
    
//MARK: Variables
    var images:UIImage?
    var task: URLSessionDataTask!
    var viewmodel = ModelAPI()
    
    
//MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splashConstraints()
        view.backgroundColor = .black
        tblView.dataSource = self
        tblView.delegate = self
        let anonymousFunction = {(fetchdAmiiboList: [DemoAPI]) in
        DispatchQueue.main.async {
        self.viewmodel.DemoList = fetchdAmiiboList
        self.tblView.reloadData() }}
        ModelAPI.shared.fetchData(onCompletion: anonymousFunction)
      tblView.refreshControl = refresher
    }

//MARK: Splash Screen
    let arImage = UIImageView(image: UIImage(named: "AppIcon300")!)
     let splashView = UIView()
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async{
            self.scaleDownAnimation()
        }
    }
    
    func splashConstraints(){
        splashView.backgroundColor = UIColor(red:256/256, green:53/256,blue:79/256,alpha: 1.0)
                    view.addSubview(splashView)
                    splashView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
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
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            self.arImage.transform = CGAffineTransform(scaleX: 5, y: 5)
        }) { (success) in
            self.removeSplashScreen()
        }
        
    }
    
    func removeSplashScreen(){
        
        splashView.removeFromSuperview()
    }
    
    
//MARK: UIRefreshControl
    
    lazy var refresher:UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .red
        refreshControl.addTarget(self, action: #selector(requestData), for: .valueChanged)
        return refreshControl
    }()
       
    @objc func requestData(){
        self.refresher.endRefreshing()
    }
    
    
func fecthes(from url:URL) -> UIImage?{
  images = nil
  if let task = task
 {
    task.cancel()
    }
    if let imageFromCache = imagCache.object(forKey: url.absoluteString as AnyObject) as? UIImage{
        self.images = imageFromCache
    }
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        
        guard let data = data,let newImage = UIImage(data: data)else{
            return
        }
        imagCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
        DispatchQueue.main.async {
            self.images = newImage
        }
    }
    task.resume()
    return images
    }
    
//MARK: Navigation
    
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
let destinationVC = segue.destination as! SecondViewController

        if let indexPath = tblView.indexPathForSelectedRow
        {
            print("\(indexPath)")
            destinationVC.name = viewmodel.DemoList[indexPath.row].author
            destinationVC.a = viewmodel.DemoList[indexPath.row].downloadurl
        }
        else
        {
            print("error in prepareSegue")
        }
    }
}

//MARK: TableViewDataSource and Delegate
extension StoryBorViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel.DemoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let amiibo = viewmodel.DemoList[indexPath.row]
         guard let amCell = cell as? TableViewCell else {
             return cell
         }
        
         amCell.authorLabel.text = amiibo.author
         amCell.idLabel.text =  amiibo.id
         if let url = URL(string: amiibo.downloadurl!){
            images = fecthes(from: url)
            amCell.imgView.image = images
        }
         return cell
    }
}

extension StoryBorViewController:UITableViewDelegate{    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
        
    }
    
}
