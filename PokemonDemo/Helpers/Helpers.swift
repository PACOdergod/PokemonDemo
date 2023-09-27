//
//  Helpers.swift
//  PokemonDemo
//
//  Created by FAMM on 26/09/23.
//

import Foundation


class Helpers {
    static func callApi<T: Codable>(url: URL, model: T.Type, completion: @escaping (T)->Void, failure: @escaping (Error)->Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                if let error = error {
                    DispatchQueue.main.async {
                        failure(error)
                    }
                }
                return
            }
            
            do {
                let serverData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(serverData)
                }
            } catch {
                DispatchQueue.main.async {
                    failure(error)
                }
            }
        }.resume()
    }
}
