//
//  DataMediator+Helper.swift
//  ECommerceSample
//
//  Created by Pratik on 19/05/20.
//  Copyright © 2020 Pratik. All rights reserved.
//

import Foundation
enum RequstDataType {
    case CategoryList
    var generatedURL : String {
        var url = APIConstant.baseURL
        switch self {
        case .CategoryList:
            url.append("json")
           return url
        }
    }
}
