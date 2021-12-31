//
//  SliderApiService.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/28.
//
//  DEPRECATED

import SwiftUI

@available(*, deprecated)
struct SliderApiService: SliderApiServiceProtocol {
    
    func getSliders(url: URL?, completion: @escaping(Result<[SliderEntity], ApiError>) -> Void) {
        guard let url = url else {
            completion(Result.failure(ApiError.badURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error as? URLError {
                completion(Result.failure(ApiError.url(error)))
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(ApiError.badResponse(statusCode: response.statusCode)))
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(Response<[SliderEntity]>.self, from: data)
                    if result.success {
                        completion(Result.success(result.data!))
                    } else {
                        completion(Result.failure(ApiError.server(error: result.message)))
                    }
                } catch {
                    completion(Result.failure(ApiError.parsing(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
}
