//
//  VideoPlayListResponse.swift
//  MP3List
//
//  Created by Gayoung Kim on 4/28/24.
//

import Foundation

struct VideoPlayListResponse: Decodable {
    enum CodingKeys: CodingKey {
        case id
        case name
        case type
        case videoList
        case description
    }
    
    let id: Int?
    let name: String
    let type: String
    var videoList: [VideoResponse]
    let description: String

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decode(Int?.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        type = try values.decode(String.self, forKey: .type)
        videoList = try values.decode([VideoResponse].self, forKey: .videoList)
        description = try values.decode(String.self, forKey: .description)
    }
}
