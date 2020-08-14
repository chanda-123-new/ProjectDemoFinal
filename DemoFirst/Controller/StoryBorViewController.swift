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

//MARK:- Outlets
    @IBOutlet weak var tblView: UITableView!
    
    
//MARK: Variables
    var images:UIImage?
    var viewmodel = ModelAPI()
    let splashData = SplashScreen()
    var imgAPI = ImageAPI()
    
//MARK: ViewDidLoad
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        splashData.splashConstraints(width:view.bounds.width,height: view.bounds.height)
        view.addSubview(splashData.splashView)
        view.backgroundColor = .black
        tblView.dataSource = self
        tblView.delegate = self
        let anonymousFunction = {(fetchdAmiiboList: [DemoAPI]) in
        DispatchQueue.main.async {
        self.viewmodel.DemoList = fetchdAmiiboList
        self.tblView.reloadData() }}
        ModelAPI.shared.fetchData(onCompletion: anonymousFunction)
      tblView.refreshControl = refresher
         splashData.scaleDownAnimation()
        
        
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
            images = imgAPI.fecthes(from:url)//fecthes(from: url)
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
