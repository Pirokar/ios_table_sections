//
//  ViewController.swift
//  Table Sections
//
//  Created by Vladimir Rybalka on 07/08/2017.
//  Copyright © 2017 Vladimir Rybalka. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    let sectionsTableIdentifier = "SectionsTableIdentifier"
    var names: [String: [String]]!
    var keys: [String]!
    var searchController: UISearchController!
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: sectionsTableIdentifier)
        let path = Bundle.main.path(forResource: "sortednames", ofType: "plist")
        
        names = NSDictionary(contentsOfFile: path!) as! [String : [String]]
        keys = ((NSDictionary(contentsOfFile: path!))?.allKeys as! [String]).sorted(by: <)
    
        let resultsController = SearchResultsControllerTableViewController()
        resultsController.names = names
        resultsController.keys = keys
        searchController = UISearchController(searchResultsController: resultsController)
        let searchBar = searchController.searchBar
        searchBar.scopeButtonTitles = ["All", "Short", "Long"]
        searchBar.placeholder = "Enter a search term"
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar
        searchController.searchResultsUpdater = resultsController
        
        tableView.sectionIndexBackgroundColor = UIColor.black
        tableView.sectionIndexTrackingBackgroundColor = UIColor.darkGray
        tableView.sectionIndexColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Table View Data Source Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = keys[section]
        let nameSection = names[key]
        
        return (nameSection?.count)!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: sectionsTableIdentifier, for: indexPath)
        let key = keys[indexPath.section]
        let nameSection = names[key]
        
        cell.textLabel?.text = nameSection?[indexPath.row]
        
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return keys
    }

}

