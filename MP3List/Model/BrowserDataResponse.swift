//
//  DataResponse.swift
//  MP3List
//
//  Created by Gayoung Kim on 4/28/24.
//

import Foundation

struct BrowserDataResponse: Decodable {
    enum CodingKeys: CodingKey {
        case chartList
        case sectionList
        case programCategoryList
        case videoPlayList
    }
    
    var chartList: [ChartListResponse]
    var sectionList: [SectionListResponse]
    var programCategoryList: ProgramCategoryListResponse
    var videoPlayList: VideoPlayListResponse

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        chartList = try values.decode([ChartListResponse].self, forKey: .chartList)
        sectionList = try values.decode([SectionListResponse].self, forKey: .sectionList)
        programCategoryList = try values.decode(ProgramCategoryListResponse.self, forKey: .programCategoryList)
        videoPlayList = try values.decode(VideoPlayListResponse.self, forKey: .videoPlayList)
    }
}
