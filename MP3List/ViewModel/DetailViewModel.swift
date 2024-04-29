//
//  LyricsViewModel.swift
//  MP3List
//
//  Created by Gayoung Kim on 4/29/24.
//

import Foundation

class DetailViewModel {
//    private var lyrics: Lyrics

//    init() {
//        lyrics = Lyrics(content: """
//        모르는 줄 몰랐지
//        사랑해 본 줄 알았지
//        네가 내 맘속에 오기 전엔
//        나도 안다고 믿었지
//
//        별거 없는 한마디 
//        연락 한 통에
//        괜히 혼자 들뜬 기분이 돼
//        날 바라볼 때
//        살짝 웃을 때
//        그냥 널 따라 웃게 돼
//
//        너를 알아갈수록 더
//        알면 알수록 더
//        더욱더 좋아지는 너
//        사랑 이게 맞나 봐
//        벅차는 이 느낌을 놓치기 싫어
//         
//        날 바라봐 줄수록 더
//        안아줄수록 더
//        더 네 맘을 갖고 싶어
//        사랑 이게 맞나 봐
//        이보다 좋은 건
//        있을 수 없을 것만 같아
//
//        아직까지는 어색해
//        서툴러도 조금 이해해 줄래
//
//        혹시 내 한 마디가
//        분위기를 깰까
//        썼다 지웠다 계속 반복해
//        고갤 떨군 채
//        힘들어할 땐
//        말없이 너를 안게 돼
//
//        너를 알아갈수록 더
//        알면 알수록 더
//        더욱더 좋아지는 너
//        사랑 이게 맞나 봐
//        이보다 좋은 건 있을 수 없을 것만 같아
//
//        너로 인해 알게 됐어
//        온전히 사랑한다는 걸
//        계속 널 향해 갈 테니까
//        나를 힘껏 안아줘
//
//        사랑 이게 맞나 봐
//        벅차는 이 느낌을 놓치기 싫어
//
//        날 바라봐 줄수록 더
//        안아줄수록 더
//        더 네 맘을 갖고 싶어
//        사랑 이게 맞나 봐
//        이보다 좋은 건 있을 수 없을 것만 같아
//        """)
//    }
    
    var lyrics: String = ""
    var trackID: String = ""
    
    var onUpdate: (() -> Void)?
    var onError: ((String) -> Void)?

    func loadTrackData() {
        API.trackData(trackId: trackID, completion: { data in
            self.lyrics = data.lyrics
            self.onUpdate?()
            
        }, failure: { error in
            self.onError?("네트워크 오류")
        })
    }

    func getLyrics() -> String {
        return lyrics.isEmpty ? "가사 정보 없음" : lyrics
    }
    
    func empty() -> String {
        return lyrics
    }
}
