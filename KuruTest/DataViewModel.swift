//
//  DataViewModel.swift
//  KuruTest
//
//  Created by Kuru on 2024-04-30.
//

import Foundation

import Moya
import UIKit

class DataViewModel {
    
    let provider = MoyaProvider<NewsAPI>()
    var newsModel: [NewsModel] = [NewsModel]()
    var data = String()
    private let dataService = DataManager()
    var items: [NewsModel] = []
    
    func fetchItems(completion: @escaping (Error?) -> Void) {
        let headers = ["Content-Type": "application/json"]
        dataService.fetchItems(headers: headers) { result in
            switch result {
            case .success(let items):
                self.items = items
                print("item count is", self.items.count)
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
}

extension DataViewModel {

   
    func getData(completion: @escaping(_ status: Bool, _ message: String?) -> Void) {
        provider.request(.getNewsData) { result in
            switch result {
            case let .success(response):
                do {
                    let newsModel = try response.map([NewsModel].self)
                    self.newsModel = newsModel
                    print(self.newsModel.count)
                    completion(true, nil)
                } catch {
                    // Handle decoding error
                    print("Error decoding response:", error)
                    completion(false, nil)
                }
            case let .failure(error):
                // Handle network request failure
                print("Network request failed:", error)
            }
        }

    }
}


