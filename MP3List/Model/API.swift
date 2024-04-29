//
//  API.swift
//  MP3List
//
//  Created by Gayoung Kim on 4/28/24.
//

import Foundation
import Alamofire

struct API {
    private static let baseURL = "https://raw.githubusercontent.com/dreamus-ios/challenge/main/"

    static func browserData(completion: @escaping(BrowserDataResponse)->Void, failure: @escaping (Error?) -> Void) {
        let url = "\(baseURL)browser"
        AF.request(url)
            .responseDecodable(of: Response<BrowserDataResponse>.self) { response in
                switch response.result {
                case .success(let responseData):
                    DispatchQueue.main.async {
                        completion(responseData.data)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        failure(error)
                    }
                }
            }
    }
    
    static func trackData(trackId: String, completion: @escaping (TrackResponse) -> Void, failure: @escaping (Error?) -> Void) {
        let url = "\(baseURL)track/\(trackId)"
        AF.request(url)
            .responseDecodable(of: Response<TrackResponse>.self) { response in
                switch response.result {
                case .success(let responseData):
                    DispatchQueue.main.async {
                        completion(responseData.data)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        failure(error)
                    }
                }
        }
    }
}
