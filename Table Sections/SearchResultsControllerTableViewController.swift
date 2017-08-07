//
//  SearchResultsControllerTableViewController.swift
//  Table Sections
//
//  Created by Vladimir Rybalka on 07/08/2017.
//  Copyright © 2017 Vladimir Rybalka. All rights reserved.
//

import UIKit

class SearchResultsControllerTableViewController: UITableViewController, UISearchResultsUpdating {
    let sectionsTableIdentifier = "SectionsTableIdentifier"
    var names: [String: [String]] = [String: [String]]()
    var keys: [String] = []
    var filteredNames: [String] = []
    
    private let longNameSize = 6
    private let shortNamesButtonIndex = 1
    private let longNamesButtonIndex = 2

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: sectionsTableIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: sectionsTableIdentifier)!
        cell.textLabel?.text = filteredNames[indexPath.row]
        
        return cell
    }
    
    // MARK: - UISearchResultsUpdating Conformance
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        let buttonIndex = searchController.searchBar.selectedScopeButtonIndex
        
        filteredNames.removeAll(keepingCapacity: true)
        if(!searchString!.isEmpty) {
            let filter: (String) -> Bool = {name in
                let nameLength = name.characters.count
                if(buttonIndex == self.shortNamesButtonIndex && nameLength >= self.longNameSize) || (buttonIndex == self.longNamesButtonIndex && nameLength < self.longNameSize) {
                    return false
                }
                let range = name.range(of: searchString!, options: NSString.CompareOptions.caseInsensitive)
                return range != nil
            }
            
            for key in keys {
                let namesForKey = names[key]
                let matches = namesForKey?.filter(filter)
                filteredNames += matches!
            }
        }
        
        tableView.reloadData()
    }
}
