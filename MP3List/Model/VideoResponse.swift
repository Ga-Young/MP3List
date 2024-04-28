//
//  VideoResponse.swift
//  MP3List
//
//  Created by Gayoung Kim on 4/28/24.
//

import Foundation

struct VideoResponse: Decodable {
    enum CodingKeys: CodingKey {
        case id
        case videoNm
        case playTm
        case thumbnailImageList
        case representationArtist
    }
    
    let id: Int
    let videoNm: String
    let playTm: String
    var thumbnailImageList: [ImageResponse]
    let representationArtist: ArtistResponse

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        videoNm = try values.decode(String.self, forKey: .videoNm)
        playTm = try values.decode(String.self, forKey: .playTm)
        thumbnailImageList = try values.decode([ImageResponse].self, forKey: .thumbnailImageList)
        representationArtist = try values.decode(ArtistResponse.self, forKey: .representationArtist)
    }
}
