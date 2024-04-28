//
//  ChartListResponse.swift
//  MP3List
//
//  Created by Gayoung Kim on 4/28/24.
//

import Foundation

struct ChartListResponse: Decodable {
    enum CodingKeys: CodingKey {
        case type
        case id
        case name
        case totalCount
        case trackList
        case basedOnUpdate
        case description
    }
    
    let type: String
    let id: Int
    let name: String
    let totalCount: Int
    var trackList: [TrackListResponse]
    let basedOnUpdate: String
    let description: String

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decode(String.self, forKey: .type)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        totalCount = try values.decode(Int.self, forKey: .totalCount)
        trackList = try values.decode([TrackListResponse].self, forKey: .trackList)
        basedOnUpdate = try values.decode(String.self, forKey: .basedOnUpdate)
        description = try values.decode(String.self, forKey: .description)
    }
}
