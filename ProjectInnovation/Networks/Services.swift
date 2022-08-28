//
//  Services.swift
//  ProjectInnovation
//
//  Created by Shubham Kushwaha on 28/08/22.
//

import Foundation
import Alamofire

class Services {
    fileprivate var baseUrl = ""
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func getAllCountriesName(endPoint: String,  onSuccess:(@escaping (DogsData)->()), onFailure:(@escaping (String)->())) {
        Alamofire.request(self.baseUrl + endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).response {
            (response) in
            guard let response = response.data else {
                onFailure("Something went wrong")
                return
            }
            print("Response have been recieved")
            do {
            let dogsData = try JSONDecoder().decode(DogsData.self, from: response)
                onSuccess(dogsData)
                print(dogsData)
            }
            catch {
                onFailure("Something Went Wrong")
                print("Something wrong has occurred")
            }
        }
    }
    
}
