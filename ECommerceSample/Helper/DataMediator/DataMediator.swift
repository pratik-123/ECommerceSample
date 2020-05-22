//
//  DataMediator.swift
//  ECommerceSample
//
//  Created by Pratik on 19/05/20.
//  Copyright © 2020 Pratik. All rights reserved.
//

import Foundation
final class DataMediator {
    static let shared = DataMediator()
    private lazy var serverCommunication = ServerCommunication()
    
    /// Get category data from sever
    ///  For temparary api response store in "LocalData.json" file for future use if API no longer available
    /// - Parameter dataType: API end point identifire
    func getCategoryData(dataType : RequstDataType, completionHandler:@escaping ((_ isSuccess: Bool,_ message: String?) -> Void)) {
        let request = RequestModel(url: dataType.generatedURL)
        serverCommunication.dataTask(requestObject: request) { (response) in
            guard let error = response?.error else {
                if let data = response?.data {
                    self.storeCategoryData(categoryData: data, completionHandler: completionHandler)
                } else {
                    completionHandler(false, "No data found")
                }
                return
            }
            print(error)
            completionHandler(false, error.localizedDescription)
        }
    }
    
    /// Get data from json file and store in local dab
    /// - Parameter completionHandler: completion block
    func getCategoryFromJsonFile(completionHandler:@escaping ((_ isSuccess: Bool,_ message: String?) -> Void)) {
        do {
            if let file = Bundle.main.url(forResource: "LocalData", withExtension: "json") {
                let data = try Data(contentsOf: file)
                self.storeCategoryData(categoryData: data, completionHandler: completionHandler)
            } else {
                print("file not found")
                completionHandler(false, "file not found")
            }
        } catch {
            print(error.localizedDescription)
            completionHandler(false, error.localizedDescription)
        }
    }
}

