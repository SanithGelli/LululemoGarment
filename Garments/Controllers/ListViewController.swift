//
//  ListViewController.swift
//  Garments
//
//  Created by Sanith on 5/26/20.
//  Copyright © 2020 Sanith. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddViewControllerDelegate {
    
    //MARK:- IBOutlets
    @IBOutlet weak var addAction: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentView: UISegmentedControl!
    
    var garmentList : [Garment] = [Garment]()
    var viewModel = ListViewModel()
    
    //MARK:- Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        garmentList = viewModel.fetchRequest(index: segmentView.selectedSegmentIndex)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    //MARK:- TableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return garmentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = garmentList[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    //MARK:- Helper Methods
    func setUp() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorInset = .zero
        self.tableView.layoutMargins = .zero
        self.tableView.tableHeaderView = self.segmentView
        self.tableView.tableFooterView = UIView()
    }
    
    func saveGarments() {
        garmentList = viewModel.fetchRequest(index: segmentView.selectedSegmentIndex)
        self.tableView.reloadData()
    }
    
    //MARK:- Action Methods
    @IBAction func segmentAction(_ sender: Any) {
        garmentList = viewModel.fetchRequest(index: segmentView.selectedSegmentIndex)
        self.tableView.reloadData()
    }
    
    @IBAction func addAction(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "AddViewController") as! AddViewController
        let navVc = UINavigationController(rootViewController: vc)
        vc.navigationItem.title = "Add"
        vc.delegate = self
        self.navigationController?.present(navVc, animated: true, completion: nil)
    }
    
}

class ListViewModel {
    func fetchRequest(index: Int) -> [Garment] {
        let fetchRequest: NSFetchRequest<Garment> = Garment.fetchRequest()
        do {
            var garment = try PersistanceService.context.fetch(fetchRequest)
            
            if index == 0 {
                garment.sort { (obj1, obj2) -> Bool in
                    if let name1 = obj1.name, let name2 = obj2.name {
                        return name1.caseInsensitiveCompare(name2) == .orderedAscending
                    }
                    return false
                }
            }else {
                garment.sort { (obj1, obj2) -> Bool in
                    if let date1 = obj1.date, let date2 = obj2.date {
                        return date1 < date2
                    }
                    return false
                }
            }
            
            return garment
        }catch {
            
        }
        return [Garment]()
    }
}
