//
//  ImageResponse.swift
//  MP3List
//
//  Created by Gayoung Kim on 4/28/24.
//

import Foundation

struct ImageResponse: Decodable {
    enum CodingKeys: CodingKey {
        case size
        case url
        case width
        case height
    }
    
    let size: Int?
    let url: String
    let width: Int?
    let height: Int?

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        size = try values.decodeIfPresent(Int.self, forKey: .size)
        url = try values.decode(String.self, forKey: .url)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
    }
}
