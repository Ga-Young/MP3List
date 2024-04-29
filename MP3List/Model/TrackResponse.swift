//
//  TrackResponse.swift
//  MP3List
//
//  Created by Gayoung Kim on 4/29/24.
//

import Foundation

struct TrackResponse: Decodable {
    enum CodingKeys: CodingKey {
        case id
        case name
        case lyrics
    }
    
    let id: Int
    let name: String
    let lyrics: String

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        lyrics = try values.decode(String.self, forKey: .lyrics)
    }
}
