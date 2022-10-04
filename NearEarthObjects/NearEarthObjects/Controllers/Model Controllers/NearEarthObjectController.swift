//
//  NearEarthObjectController.swift
//  NearEarthObjects
//
//  Created by Esther on 10/4/22.
//

import Foundation

//var neoController = NearEarthObjectController()

class NearEarthObjectController {
    
    
    
    // MARK: - SOT
    
    ///  not needed (for networking) because we completed fetchNEOs with an array of NearEarthObjects
    
    
    // MARK: - URL
    /// private for this file but public to other functions in this file. If we wanted other endpoints on this API, they'd use this same base URL but require a different fetch function.
    private static let baseURLString = "https://api.nasa.gov/neo/rest/v1"
    
    // Keys (rather than hardcoding string of URL components)
    private static let kNeoComponent = "neo"
    private static let kBrowseComponent = "browse"
    private static let kAPIKeyKey = "api_key"
    private static let kAPIKeyValue = "xdfuqENDMd6cbF4XAx0Gc86gHcUHKPQsMPjPJQr6"
    
    // MARK: - CRUD
    
    // Completion Handler informs me when the fetchNEOs function has completed its task. Completion handler needed because the fetch function is responsible for hitting an API Endpoint.
    /// array of NEO not neos SOT because we are declaring the type
    /// Optional because we are using the internet and we don't want to return anything if connection is going wrong
    /// if you don't write a return type it defaults to Void, but completion handler return type must be explicitly declared
    static func fetchNEOs(completion: @escaping ([NearEarthObject]?) -> Void){
        
        // Step 1: Create URL
        /// return satisfies unwrapping, but there are two functions and we need to address completion handler.
        guard let baseURL = URL(string: baseURLString) else {completion(nil); return}
        let neoURL = baseURL.appendingPathComponent(kNeoComponent)
        /// New Swift way of writing appending:
        let browseURL = neoURL.appending(path: kBrowseComponent)
        
        /// To use URL query items you need a URLComponenet Struct, which is called in the final URL
        var urlComponents = URLComponents(url: browseURL, resolvingAgainstBaseURL: true)
        
        /// Query item:
        let queryItem = URLQueryItem(name: kAPIKeyKey, value: kAPIKeyValue)
        urlComponents?.queryItems = [queryItem]
        
        guard let finalURL = urlComponents?.url else {completion(nil); return}
        
        print(finalURL)
        
        // Step 2: Start a data task to retrieve data
        URLSession.shared.dataTask(with: finalURL) { neoData, _, error in
            /// Handle the error first
            if let error = error {
                print("There was an error with the data task", error.localizedDescription)
                completion(nil)
            }
            
            // Check for data
            guard let data = neoData else {completion(nil); return}
            
            // Now that we have data, I can convert it to a JSON object (do, try, catch)
            do {
                /// Karl believes this topLevelDictionary should be passed to Model object to take care of its data rather than parsing it within the function here on the Model Controller. Create fail-able initializer in model file
                /// DO NOT NEED to Catch if we OPTIONALLY Try
                guard let topLevelDictionary = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String:Any],
                      let neosArray = topLevelDictionary["near_earth_objects"] as? [[String:Any]] else
                {completion(nil); return}
                /// Access data one at a time with for-in loop and create a temporary array to hold onto these individual neos
                var tempNeoArray: [NearEarthObject] = []
                for neoDictionary in neosArray {
                    guard let neo = NearEarthObject(dictionary: neoDictionary) else {completion(nil)
                        return}
                    tempNeoArray.append(neo)
                }
                /// The completion of fetchNEOs when successful once complete with all prerequisite tasks
                completion(tempNeoArray)
            }
            /// Resume a suspended state of a function. Newly initialized tasks begin in suspended state.
        } .resume()
    }
} // End of Class
