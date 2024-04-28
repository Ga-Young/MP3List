//
//  ShortcutResponse.swift
//  MP3List
//
//  Created by Gayoung Kim on 4/28/24.
//

import Foundation

struct ShortcutResponse: Decodable {
    enum CodingKeys: CodingKey {
        case type
        case id
        case name
        case imgList
    }
    
    let type: String
    let id: Int
    let name: String
    var imgList: [ImageResponse]

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decode(String.self, forKey: .type)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        imgList = try values.decode([ImageResponse].self, forKey: .imgList)
    }
}
