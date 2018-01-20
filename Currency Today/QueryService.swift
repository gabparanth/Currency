//
//  QueryService.swift
//  Currency Today
//
//  Created by Gabriel Paranthoen on 18/01/2018.
//  Copyright © 2018 Gabriel Paranthoen. All rights reserved.
//
import Foundation


//  https://api.coinmarketcap.com/v1/ticker/?limit=5

// Runs query data task, and stores results in array of Tracks
class QueryService {
    
    typealias JSONDictionary = [[String: Any]]
    typealias QueryResult = ([Coin]?, String) -> ()
    
    // 1
    let defaultSession = URLSession(configuration: .default)
    // 2
    var dataTask: URLSessionDataTask?
    var coins: [Coin] = []
    var errorMessage = ""
    
    func getSearchResults(completion: @escaping QueryResult) {
        dataTask?.cancel()
        if var urlComponents = URLComponents(string: "https://api.coinmarketcap.com/v1/ticker/?limit=1") {
            //   urlComponents.query = "ticker/?limit=\(searchTerm)"
            guard let url = urlComponents.url else { return }
            
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                if let error = error {
                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    //                     the following is used to test my json
                    //                                            if let stringData = String(data: data, encoding: String.Encoding.utf8) {
                    //                                            print(stringData) //JSONSerialization
                    //                                    }
                    
                    self.updateSearchResults(data)
                    
                    DispatchQueue.main.async {
                        completion(self.coins, self.errorMessage)
                    }
                }
            }
            dataTask?.resume()
        }
    }
    
    fileprivate func updateSearchResults(_ data: Data) {
        
        //coins.removeAll()
        
        //        do {
        //            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        //        } catch let parseError as NSError {
        //            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
        //            return
        //        }
        //
        //        guard let array = response as? JSONDictionary else {
        //            errorMessage += "Dictionary does not contain results key\n"
        //            return
        //        }
        guard let parsedData = try? JSONSerialization.jsonObject(with: data) as? JSONDictionary else{
            errorMessage += "Dictionary does not contain results key\n"
            return}
        
        
        var index = 0
        for coinDictionary in parsedData! {
            if let id = coinDictionary["id"] as? String,
                let name = coinDictionary["name"] as? String,
                let symbol = coinDictionary["symbol"] as? String,
                let rank = coinDictionary["rank"] as? String {
               // print (id)
                coins.append(Coin(id: id, name: name, symbol: symbol, rank: rank))
                index += 1
            } else {
                errorMessage += "Problem parsing trackDictionary\n"
            }
        }
    }
    
}

