//
//  API.swift
//  MP3List
//
//  Created by Gayoung Kim on 4/28/24.
//

import Foundation
import Alamofire

struct API {
    private static let URL_CHART_DATA = "https://raw.githubusercontent.com/dreamus-ios/challenge/main/browser"

    static func browserData(completion: @escaping(BrowserDataResponse)->Void, failure: @escaping (Error?) -> Void) {
        AF.request(URL_CHART_DATA)
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
}
