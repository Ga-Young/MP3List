//
//  ProgramCategoryResponse.swift
//  MP3List
//
//  Created by Gayoung Kim on 4/28/24.
//

import Foundation

struct ProgramCategoryResponse: Decodable {
    enum CodingKeys: CodingKey {
        case programCategoryId
        case programCategoryType
        case displayTitle
        case imgUrl
    }
    
    let programCategoryId: Int
    let programCategoryType: String
    let displayTitle: String
    let imgUrl: String

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        programCategoryId = try values.decode(Int.self, forKey: .programCategoryId)
        programCategoryType = try values.decode(String.self, forKey: .programCategoryType)
        displayTitle = try values.decode(String.self, forKey: .displayTitle)
        imgUrl = try values.decode(String.self, forKey: .imgUrl)
    }
}
