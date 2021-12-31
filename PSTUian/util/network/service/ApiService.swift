//
//  ApiService.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/28.
//

import SwiftUI

struct ApiService: ApiServiceProtocol {
    
    func fetch<T: Codable>(_ type: T.Type, url: URL?, completion: @escaping(Result<T, ApiError>) -> Void) {
        guard let url = url else {
            completion(Result.failure(ApiError.badURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error as? URLError {
                // URLError
                completion(Result.failure(ApiError.url(error)))
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                // Bad response
                completion(Result.failure(ApiError.badResponse(statusCode: response.statusCode)))
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(Response<T>.self, from: data)
                    if result.success {
                        // Success
                        completion(Result.success(result.data!))
                    } else {
                        // Server side error
                        completion(Result.failure(ApiError.server(error: result.message)))
                    }
                } catch {
                    // Parse Error
                    completion(Result.failure(ApiError.parsing(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
}
