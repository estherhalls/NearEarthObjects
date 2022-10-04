//
//  NEOListTableViewController.swift
//  NearEarthObjects
//
//  Created by Esther on 10/4/22.
//

import UIKit

class NEOListTableViewController: UITableViewController {

    // Placeholder Property to retrieve array data that is trapped within the fetchNEOs function on the model controller
    var neoArray: [NearEarthObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// array assignment is using closure to pass in the data
        NearEarthObjectController.fetchNEOs { array in
            /// Unwrap the property - I want it to return the value of the NEO array, not Nil.
            guard let array = array else { return }
            /// Grand Central Dispatch responsible for concurrency
            DispatchQueue.main.async {
                /// Reference self when in closure
                self.neoArray = array
                self.tableView.reloadData()
            }
        }
    }
        
        // MARK: - Table view data source
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            /// Section shows the same number of rows as data available to fill them, in this case, from the placeholder property in this file that is holding the array
            return neoArray.count
            
        }
    // Data to populate each cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /// define cell identifier to be reused
        let cell = tableView.dequeueReusableCell(withIdentifier: "neoCell", for: indexPath)
        /// define specific location within array for each set of data to display in the cell
        let neo = neoArray[indexPath.row]
        /// Default cell style configuration
        cell.textLabel?.text = "\(neo.name)"
        cell.detailTextLabel?.text = "Designation: \(neo.designation), Potentially Hazardous: \(neo.isWorldKiller)"
        return cell
    }
    
} // End of Class
