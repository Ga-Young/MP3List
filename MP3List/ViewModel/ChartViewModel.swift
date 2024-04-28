//
//  ChartViewModel.swift
//  MP3List
//
//  Created by Gayoung Kim on 4/28/24.
//

import Foundation

class ChartViewModel {
    var chartList: [ChartListResponse] = []
    var sectionList: [SectionListResponse] = []
    var programCategory: [ProgramCategoryResponse] = []
    var videoList: [VideoResponse] = []
    
    var onUpdate: (() -> Void)?
    var onError: ((String) -> Void)?

    func loadChartData() {
        API.browserData(completion: { data in
            self.chartList = data.chartList
            self.sectionList = data.sectionList
            self.programCategory = data.programCategoryList.list
            self.videoList = data.videoPlayList.videoList
            self.onUpdate?()
            
        }, failure: { error in
            self.onError?(error?.localizedDescription ?? "Failed to load data")
        })
    }
}
