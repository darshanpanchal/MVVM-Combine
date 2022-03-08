//
//  ListViewController.swift
//  MVVM
//
//  Created by Darshan on 08/03/22.
//

import UIKit
import Combine

class ListViewController: UIViewController {
    
    @IBOutlet fileprivate weak var tableView:UITableView!
   
    private let refreshControl = UIRefreshControl()

    
    var arrayOfWatchList:[WatchList] = []
    var observers:[AnyCancellable] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setup()
        self.fetchListOfData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    // MARK: - Setup
    private func setup(){
        self.tableView.register(UINib.init(nibName: "WatchListTableViewCell", bundle: nil), forCellReuseIdentifier: "WatchListTableViewCell")
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorInset = UIEdgeInsets.zero
        self.tableView.separatorStyle = .none
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.reloadData()
        self.tableView.tableHeaderView = UIView()
        self.tableView.tableFooterView = UIView()
        self.refreshControl.addTarget(self, action: #selector(refreshWatchListData(_:)), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
    }
    
    // MARK: - Data Fetching
    func fetchListOfData(){
        ViewModel().fetchWatchListData()
            .receive(on: DispatchQueue.main, options: nil)
            .sink { completion in
                self.refreshControl.endRefreshing()
                switch completion{
                case .finished:
                    print("Finish")
                case .failure(let error):
                    print("Error \(error.localizedDescription)")
                }
            } receiveValue: { value in
                self.arrayOfWatchList = value ?? []
                self.tableView.reloadData()
            }.store(in: &observers)
    }
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
// MARK: - TableView DataSource/Delefate Methods
extension ListViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.arrayOfWatchList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "WatchListTableViewCell", for: indexPath) as! WatchListTableViewCell
        cell.action.sink {[weak self] value in
            self?.buttonDeleteSelector(index: value)
        }.store(in: &observers)
        cell.watchlistModel = self.arrayOfWatchList[indexPath.row]
        cell.tag = indexPath.row
        return  cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
}
// MARK: - Selector Methods
extension ListViewController{
    @objc private func refreshWatchListData(_ sender: Any) {
        self.fetchListOfData()
    }
    @IBAction func buttonLogOutSelector(sender:UIButton){
        let alert = UIAlertController.init(title: "Logout", message: "Are you sure you want to Logout?", preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "No", style: .cancel) { yesAction in
            
        })
        alert.addAction(UIAlertAction.init(title: "Yes", style: .default) { yesAction in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
            UserDefaults.standard.removeObject(forKey: kIsUserLoggedIn)
            UserDefaults.standard.synchronize()
        })
        self.present(alert, animated: true, completion: nil)
    }
    func buttonDeleteSelector(index: Int) {
        if self.arrayOfWatchList.count > index{
            let objWatchList = self.arrayOfWatchList[index]
            let alert = UIAlertController.init(title: "Delete", message: "Are you sure you want to Delete \(objWatchList.name)?", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "No", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction.init(title: "Yes", style: .default) { yesAction in
                DispatchQueue.main.async {
                    self.arrayOfWatchList.remove(at: index)
                    self.tableView.reloadData()
                }
            })
            self.present(alert, animated: true, completion: nil)
        }
    }
}
