//
//  VideoItem.swift
//  MP3List
//
//  Created by Gayoung Kim on 4/27/24.
//

import Foundation

struct VideoItem: Identifiable {
    var id: Int
    var thumnailImageURL: String
    var playTime: String
    var title: String
    var artist: String
}
