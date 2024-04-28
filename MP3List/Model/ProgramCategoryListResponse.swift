//
//  ProgramCategoryListResponse.swift
//  MP3List
//
//  Created by Gayoung Kim on 4/28/24.
//

import Foundation

struct ProgramCategoryListResponse: Decodable {
    enum CodingKeys: CodingKey {
        case name
        case type
        case list
    }
    
    let name: String
    let type: String
    var list: [ProgramCategoryResponse]

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        type = try values.decode(String.self, forKey: .type)
        list = try values.decode([ProgramCategoryResponse].self, forKey: .list)
    }
}
