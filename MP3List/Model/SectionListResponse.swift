//
//  SectionListResponse.swift
//  MP3List
//
//  Created by Gayoung Kim on 4/28/24.
//

import Foundation

struct SectionListResponse: Decodable {
    enum CodingKeys: CodingKey {
        case name
        case type
        case shortcutList
    }
    
    let name: String
    let type: String
    var shortcutList: [ShortcutResponse]

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        type = try values.decode(String.self, forKey: .type)
        shortcutList = try values.decode([ShortcutResponse].self, forKey: .shortcutList)
    }
}
