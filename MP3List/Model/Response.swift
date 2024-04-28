//
//  Response.swift
//  MP3List
//
//  Created by Gayoung Kim on 4/28/24.
//

import Foundation

struct Response<T: Decodable>: Decodable {
    enum CodingKeys: CodingKey {
        case code
        case data
    }
    
    let code: String
    let data: T
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decode(String.self, forKey: .code)
        data = try values.decode(T.self, forKey: .data)
    }
}
