//
//  ChartViewModel.swift
//  MP3List
//
//  Created by Gayoung Kim on 4/28/24.
//

import Foundation

enum ChartType {
    case flo
    case global
}

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
            self.onError?("네트워크 오류")
        })
    }
    
    func hasFirstChart(at index: Int) -> Bool {
        return chartList.indices.contains(index)
    }

    func hasFirstSection() -> Bool {
        return sectionList.indices.contains(0)
    }

    func hasFirstProgramCategory() -> Bool {
        return programCategory.indices.contains(0)
    }
    
    func numberOfTracksInChart(chartIndex: Int) -> Int {
        guard chartList.indices.contains(chartIndex) else {
            return 0
        }
        return chartList[chartIndex].trackList.count
    }

    func chartName(at index: Int) -> String {
        guard chartList.indices.contains(index) else {
            return "Unknown Chart"
        }
        return chartList[index].name
    }

    func chartUpdateDate(at index: Int) -> String {
        guard chartList.indices.contains(index) else {
            return "No Update Date"
        }
        return chartList[index].basedOnUpdate
    }

    func chartDescription(at index: Int) -> String {
        guard chartList.indices.contains(index) else {
            return "No Description"
        }
        return chartList[index].description
    }
    
    func trackForItem(at indexPath: IndexPath, chartType: ChartType) -> TrackListResponse? {
        let chartIndex = chartType == .flo ? 0 : 1
        
        guard chartList.indices.contains(chartIndex),
            chartList[chartIndex].trackList.indices.contains(indexPath.row) else {
           return nil
        }
        
        return chartList[chartIndex].trackList[indexPath.row]
    }

    func numberOfProgramsInCategory() -> Int {
        guard programCategory.indices.contains(0) else {
            return 0
        }
        return programCategory.count
    }
    
    func programCategoryAt(index: Int) -> ProgramCategoryResponse? {
        guard programCategory.indices.contains(index) else {
            return nil
        }
        return programCategory[index]
    }
    
    func nameOfSection(at section: Int) -> String? {
        guard sectionList.indices.contains(section) else {
            return nil
        }
        return sectionList[section].name
    }
    
    func numberOfSection() -> Int {
        guard sectionList.indices.contains(0) else {
            return 0
        }
        return sectionList.count
    }
    
    func numberOfShortcutList(at section: Int) -> Int {
        guard sectionList.indices.contains(section) else {
            return 0
        }
        return sectionList[section].shortcutList.count
    }
    
    func getSectionList() -> [SectionListResponse] {
        return sectionList
    }
    
    func itemInSection(at indexPath: IndexPath) -> ShortcutResponse? {
        guard sectionList[indexPath.section].shortcutList.indices.contains(indexPath.row) else {
            return nil
        }
        return sectionList[indexPath.section].shortcutList[indexPath.row]
    }

    func numberOfVideoList() -> Int {
        guard videoList.indices.contains(0) else {
            return 0
        }
        
        return videoList.count
    }

    func videoAt(index: Int) -> VideoResponse? {
        guard videoList.indices.contains(index) else {
            return nil
        }
        return videoList[index]
    }
    
    func videoListDropFirst() -> [VideoResponse] {
        return Array(videoList.dropFirst())
    }
}
