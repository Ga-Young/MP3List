//
//  ArtistResponse.swift
//  MP3List
//
//  Created by Gayoung Kim on 4/28/24.
//

import Foundation

struct ArtistResponse: Decodable{
    enum CodingKeys: CodingKey {
        case id
        case name
    }
    
    let id: Int
    let name: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.name = try values.decode(String.self, forKey: .name)
    }
}
