//
//  AlbumResponse.swift
//  MP3List
//
//  Created by Gayoung Kim on 4/28/24.
//

import Foundation

struct AlbumResponse: Decodable {
    enum CodingKeys: CodingKey {
        case id
        case title
        case imgList
    }
    
    let id: Int
    let title: String
    let imgList: [ImageResponse]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        imgList = try values.decode([ImageResponse].self, forKey: .imgList)
    }
}
