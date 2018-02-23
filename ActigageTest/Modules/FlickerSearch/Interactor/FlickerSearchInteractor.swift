//
//  FlickerSearchInteractor.swift
//  ActigageTest
//
//  Created by Durgesh Pandey on 18/12/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import Foundation

class FlickerSearchInteractor: FlickerSearchUseCase {
    
    var output: FlickerSearchInteractorOutput!
    
    func fetchFlickerPhotosList(for searchText: String) {
        
        //Fetch Photos List
        FlickerSearchApiService.fetchFlickerSearchList(searchText) { (flickerList, isError, errorString) in
            
            //Check for Error
            if !isError {
                
                //No Error
                if let flickerListArr = flickerList?.photos?.photo {
                    
                    //List fetched successfully
                   self.output.flickerSearchListFetchedSuccessfully(flickerListArr)
                } else {
                    
                    //No data Received or data could not be parsed
                    self.output.flickerSearchListFetchFailed()
                }
            } else {
                
                //Error
                self.output.flickerSearchListFetchFailed()
            }
        }
    }
}
