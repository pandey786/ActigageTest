//
//  FlickerSearchAPIService.swift
//  ActigageTest
//
//  Created by Durgesh Pandey on 19/12/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class FlickerSearchApiService {
    
    static func fetchFlickerSearchList(_ searchText: String, completionHandler: @escaping (_ flickerSearchList: FlickerPhotoResultModel?, _ isError: Bool, _ error: String?) -> ()) {
        
        let flickerSearchUrl = API.flickerBaseUrl + API.flickerpathForAPIKey + API.flickerAPIKey + API.flickertagKey + searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! + API.flickerarguments
        
        Alamofire.request(flickerSearchUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .validate()
            .responseString(completionHandler: { (responseString) in
                print(responseString.value ?? "Could not get proper response")
            })
            .responseObject { (response: DataResponse<FlickerPhotoResultModel>) in
                
                switch response.result {
                case .success(let flickerList):
                    
                    //Response received successfully
                    completionHandler(flickerList, false, nil)
                    break
                case .failure(let error):
                    
                    //There was an error
                    completionHandler(nil, true, error.localizedDescription)
                    break
                }
        }
    }
}
