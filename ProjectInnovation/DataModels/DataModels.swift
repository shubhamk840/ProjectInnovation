//
//  DataModels.swift
//  ProjectInnovation
//
//  Created by Shubham Kushwaha on 28/08/22.
//

import Foundation

struct DogsData: Decodable {
    var message: String?
    var status: String?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case status = "status"
    }
}
