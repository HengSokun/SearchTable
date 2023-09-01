//
//  ViewController.swift
//  searchTable
//
//  Created by heng on 1/9/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,
    UISearchBarDelegate{
    
    var data = [
        ["Dev", "Hiren", "Bhagyashree"],
        ["Himanshu", "Manisha"],
        ["Trupti"],
        ["Prashant", "Kishor", "Hignesh", "Rushi"]
    ]
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableShow: UITableView!
    
    var isSearch: Bool = false
    var searchItem = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableShow.dataSource = self
        tableShow.delegate = self
        searchBar.delegate = self
        tableShow.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if isSearch && searchItem[section].isEmpty{
            return nil
        }
        
        return "Section \(section + 1)"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isSearch {
            return searchItem.count
        }
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch {
            return searchItem[section].count
        }
        
        return data[section].count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        print("==========")
        print("indexPath: \(indexPath)")
        print("indexPath.section: \(indexPath.section)")
        print("indexPath.row: \(indexPath.row)")
        print("searchItem: \(searchItem)")
        
        if isSearch {
            cell.textLabel?.text = searchItem[indexPath.section][indexPath.row]
        }
        else {
            cell.textLabel?.text = data[indexPath.section][indexPath.row]
        }
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            isSearch = false
            searchItem.removeAll()
        } else {
            isSearch = true
            searchItem = data.map { $0.filter { $0.lowercased().contains(searchText.lowercased()) } }
        }

        tableShow.reloadData()
    }
}

