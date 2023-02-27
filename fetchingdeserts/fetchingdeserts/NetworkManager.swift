//
//  NetworkManager.swift
//  fetchingdeserts
//
//  Created by Odinaka Amadi on 2/27/23.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let session: URLSession
    init (session: URLSession = URLSession.shared) {
        self.session = session
    }
}

extension NetworkManager{
    func fetchPage(urlStr: String, completion: @escaping(Result<DesertPage, Error>) -> Void) {
        guard let url = URL(string: urlStr) else {
            // completion error
            return
        }
        self.session.dataTask(with: url) { data, response, error in
            // Do error handling
            guard let data = data else {
                return
            }
            
            do {
                let page = try JSONDecoder().decode(DesertPage.self, from: data)
                completion(.success(page))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    func fetchPage2(mealId: String, completion: @escaping(DesertDetails) -> Void) {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(mealId)") else {
            // completion error
            return
        }
        self.session.dataTask(with: url) { data, response, error in
            // Do error handling
            guard let data = data else {
                return
            }
            
            do {
                let page = try JSONDecoder().decode(DesertDetails.self, from: data)
                completion(page)
            } catch {
                print("DEBUG: Error \(error.localizedDescription)")

            }
        }.resume()
    }
    
    func fetchImageData(urlStr: String, completion: @escaping (Result<Data,Error>) -> Void) {
        guard let url = URL(string: urlStr) else {
            // completion error
            return
        }
        self.session.dataTask(with: url) { data, response, error in
            // Do error handling
            guard let data = data else {
                return
            }
                completion(.success(data))
        }.resume()
    }
}
