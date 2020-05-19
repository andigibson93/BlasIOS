//
//  APIHelper.swift
//  BlasIOS
//
//  Created by Andi Gibson on 4/27/20.
//  Copyright © 2020 Andi Gibson. All rights reserved.
//

import Foundation
import Alamofire

class APIHelper {
    
    static let HOST = "https://blasapi.herokuapp.com"
    
    static func getAssets(categoryName:String, completion: @escaping (_ assest:Assets?, _ error:String?)->()) -> Void{
        AF.request(APIHelper.HOST + "/categories" + "/\(categoryName)", method: .get).responseDecodable(of: Assets.self) { response in
            print("Response: \(response)")
           
            let result = response.result
            switch result {
                
            case .success(let assest):
                completion(assest, nil)
                break
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    static func getCategories(completion: @escaping (_ categories:Categories?, _ error:String?)->()) -> Void{
        AF.request(APIHelper.HOST + "/categories" , method: .get).responseDecodable(of: Categories.self) { response in
            print("Response: \(response)")
           
            let result = response.result
            switch result {
                
            case .success(let categories):
                
                
                completion(categories, nil)
                break
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    static func getImageEndpointURL(categoryName:String, endpoint: String) -> URL {
        return URL(string: APIHelper.HOST + "/\(categoryName)" + "/\(endpoint)")!
    }
}
