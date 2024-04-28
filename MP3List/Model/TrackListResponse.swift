//
//  TrackListResponse.swift
//  MP3List
//
//  Created by Gayoung Kim on 4/28/24.
//

import Foundation

struct TrackListResponse: Decodable {
    enum CodingKeys: CodingKey {
        case id
        case name
        case album
        case representationArtist
    }
    
    let id: Int
    let name: String
    let album: AlbumResponse
    let representationArtist: ArtistResponse

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        album = try values.decode(AlbumResponse.self, forKey: .album)
        representationArtist = try values.decode(ArtistResponse.self, forKey: .representationArtist)
    }
}
