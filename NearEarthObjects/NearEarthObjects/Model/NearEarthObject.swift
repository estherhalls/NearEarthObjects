//
//  NearEarthObject.swift
//  NearEarthObjects
//
//  Created by Esther on 10/4/22.
//

import Foundation

class NearEarthObject {
    
    let name: String
    let designation: String
    let isWorldKiller: Bool
    
    // Memberwise Initializer - every class (in the model?) needs this.
    init(name: String, designation: String, isWorldKiller: Bool) {
        self.name = name
        self.designation = designation
        self.isWorldKiller = isWorldKiller
    }
    // Failable initializer = optional
    init?(dictionary: [String:Any]) {
        /// as? = type cast; ["xxx"] = subscript syntax
        guard let name = dictionary["name_limited"] as? String else {return nil}
        guard let designation = dictionary["designation"] as? String else {return nil}
        guard let isWK = dictionary["is_potentially_hazardous_asteroid"] as? Bool else {return nil}
        
        
        self.name = name
        self.designation = designation
        self.isWorldKiller = isWK
        
    }
    
} // End of Class

/**
 BROWSE ENDPOINT OF NASA NEO API
 
 Example of what the JSON Object looks like:
 { TLD (Top Level Dictionary)
     "links": {
        
     },
     "page": {
        
     },
     "near_earth_objects": [
         {
             "links": {
                 "self": "http://api.nasa.gov/neo/rest/v1/neo/2000433?api_key=xdfuqENDMd6cbF4XAx0Gc86gHcUHKPQsMPjPJQr6"
             },
             "id": "2000433",
             "neo_reference_id": "2000433",
             "name": "433 Eros (A898 PA)",
             "name_limited": "Eros",
             "designation": "433",
             "nasa_jpl_url": "http://ssd.jpl.nasa.gov/sbdb.cgi?sstr=2000433",
             "absolute_magnitude_h": 10.31,
             "estimated_diameter": {
                 "kilometers": {
                     "estimated_diameter_min": 23.0438466577,
                     "estimated_diameter_max": 51.5276075896
                 },
                 "meters": {
                     "estimated_diameter_min": 23043.8466576534,
                     "estimated_diameter_max": 51527.6075895943
                 },
                 "miles": {
                     "estimated_diameter_min": 14.3187780415,
                     "estimated_diameter_max": 32.0177610556
                 },
                 "feet": {
                     "estimated_diameter_min": 75603.1738682955,
                     "estimated_diameter_max": 169053.8360842445
                 }
             },
             "is_potentially_hazardous_asteroid": false,
             "close_approach_data": [
                 {
                     "close_approach_date": "1900-12-27",
                     "close_approach_date_full": "1900-Dec-27 01:30",
                     "epoch_date_close_approach": -2177879400000,
                     "relative_velocity": {
                         "kilometers_per_second": "5.5786191875",
                         "kilometers_per_hour": "20083.0290749201",
                         "miles_per_hour": "12478.8132604691"
                     },
                     "miss_distance": {
                         "astronomical": "0.3149291693",
                         "lunar": "122.5074468577",
                         "kilometers": "47112732.928149391",
                         "miles": "29274494.7651919558"
                     },
                     "orbiting_body": "Earth"
                 },
 
 */
