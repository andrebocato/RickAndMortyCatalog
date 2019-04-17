//
//  LocationsViewController.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class LocationsViewController: UIViewController {
    
    // MARK: - Dependencies
    
    let service = RMLocationsService()
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    // MARK: - IBActions
    
    // MARK: - Properties
    
    var locations = [RMLocation]() {
        didSet {
            tableView.reloadData()
        }
    }
    var selectedLocation: RMLocation!
    
    // MARK: - Lifecycle
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? LocationDetailViewController, segue.destination is LocationDetailViewController else { return }
        
        if segue.identifier == "LocationDetailSegue" {
            destination.location = selectedLocation
        }
    }
    
    // MARK: - Functions
    
    // MARK: - Configuration Functions
    
    // MARK: - Helper Functions
    
}

// MARK: - Extensions

extension LocationsViewController: UITableViewDataSource {
    
    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationCell.identifier, for: indexPath) as? LocationCell else { return UITableViewCell() }
        
        let location = locations[indexPath.row]
        cell.configure(with: location)
        
        return cell
    }
    
}

extension LocationsViewController: UITableViewDelegate {
    
    // MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedLocation = locations[indexPath.row]
        performSegue(withIdentifier: "LocationDetailSegue", sender: self)
    }
    
}
