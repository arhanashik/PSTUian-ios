//
//  ApiService.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/28.
//

import SwiftUI

struct ApiService: ApiServiceProtocol {
    
    func get<Param: Codable, T: Codable>(_ type: T.Type, url: URL?, param: Param?, completion: @escaping(Result<T, ApiError>) -> Void) {
        // Create URL
        guard let url = url else {
            completion(Result.failure(ApiError.badURL))
            return
        }
        guard let param = param else {
            // Request without parameter
            var urlRequest = URLRequest(url: url)
            urlRequest.addValue("unknown", forHTTPHeaderField: "x-auth-token")
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                processResponse(type, data: data, response: response, error: error, completion: completion)
            }
            task.resume()
            return
        }
        requestWithParam(type, url: url, param: param, method: .get, completion: completion)
    }
    
    func post<Param: Codable, T: Codable>(_ type: T.Type, url: URL?, param: Param, completion: @escaping (Result<T, ApiError>) -> Void) {
        // Create URL
        guard let url = url else {
            completion(Result.failure(ApiError.badURL))
            return
        }
        requestWithParam(type, url: url, param: param, method: .post, completion: completion)
    }
    
    func auth<Param: Codable, T: Codable>(_ type: T.Type, url: URL?, param: Param?, completion: @escaping (Result<AuthResponse<T>, ApiError>) -> Void) {
        // Create URL
        guard let url = url else {
            completion(Result.failure(ApiError.badURL))
            return
        }
        // Create URLRequest
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTP.Method.post.rawValue
        // Set headers
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "x-auth-token": "unknown"
        ]
        urlRequest.allHTTPHeaderFields = headers
        // Add parameters
        do {
            let paramDict: [String: Any] = try param.asDictionary()
            if !paramDict.isEmpty {
                var paramArr = [String]()
                for(key, value) in paramDict {
                    paramArr.append(key + "=\(value)")
                }
                let paramStr = paramArr.map { String($0) }.joined(separator: "&")
                urlRequest.httpBody = paramStr.data(using: .utf8)
            }
        } catch {
            // Parse Error
            completion(Result.failure(ApiError.encoding(error as? EncodingError)))
            return
        }
        print("request------>")
        print(urlRequest)
        print(urlRequest.httpMethod!)
        print(urlRequest.allHTTPHeaderFields!)
        print("params------>")
        print(String(data: urlRequest.httpBody ?? "none".data(using: .utf8)!, encoding: .utf8)!)
        // Perform request
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            processAuthResponse(type, data: data, response: response, error: error, completion: completion)
        }
        task.resume()
    }
    
    private func requestWithParam<Param: Codable, T: Codable>(_ type: T.Type, url: URL, param: Param, method: HTTP.Method, completion: @escaping(Result<T, ApiError>) -> Void) {
        // Init parameters
        let paramDict: [String: Any]
        do {
            paramDict = try param.asDictionary()
        } catch {
            // Parse Error
            completion(Result.failure(ApiError.encoding(error as? EncodingError)))
            return
        }
        // Create URLRequest
        var urlRequest: URLRequest
        if method == .get {
            guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                completion(Result.failure(ApiError.badURL))
                return
            }
            // Add params for get request
            var queryItems = urlComponents.queryItems ?? [URLQueryItem]()
            for(key, value) in paramDict {
                queryItems.append(URLQueryItem(name: key, value: String(describing: value)))
            }
            urlComponents.queryItems = queryItems
            urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
            
            urlRequest = URLRequest(url: urlComponents.url!)
        } else {
            urlRequest = URLRequest(url: url)
            
            // Add params for post request
            if !paramDict.isEmpty {
                var paramArr = [String]()
                for(key, value) in paramDict {
                    paramArr.append(key + "=\(value)")
                }
                let paramStr = paramArr.map { String($0) }.joined(separator: "&")
                urlRequest.httpBody = paramStr.data(using: .utf8)
            }
        }
        urlRequest.httpMethod = method.rawValue
        // Set headers
        let contentType: String
        if method == .post {
            contentType = "application/x-www-form-urlencoded"
        } else {
            contentType = "application/json"
        }
        let headers = [
            "Content-Type": contentType,
            "x-auth-token": "unknown"
        ]
        urlRequest.allHTTPHeaderFields = headers
        print("request------>")
        print(urlRequest)
        print(urlRequest.httpMethod!)
        print(urlRequest.allHTTPHeaderFields!)
        print("params------>")
        print(String(data: urlRequest.httpBody ?? "none".data(using: .utf8)!, encoding: .utf8)!)
        
        // Perform request
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            processResponse(type, data: data, response: response, error: error, completion: completion)
        }
        task.resume()
    }
    
    private func processResponse<T: Codable>(_ type: T.Type, data: Data?, response: URLResponse?, error: Error?, completion: @escaping(Result<T, ApiError>) -> Void) {
        print("response------>")
        print(String(data: data ?? "none".data(using: .utf8)!, encoding: .utf8)!)
        if let error = error as? URLError {
            // URLError
            completion(Result.failure(ApiError.url(error)))
        } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
            // Bad response
            completion(Result.failure(ApiError.badResponse(statusCode: response.statusCode)))
        } else if let data = data {
            do {
                let result = try JSONDecoder().decode(Response<T>.self, from: data)
                if result.success {
                    // Success
                    completion(Result.success(result.data!))
                } else {
                    // Server side error
                    completion(Result.failure(ApiError.server(error: result.message)))
                }
            } catch {
                // Parse Error
                print(error)
                completion(Result.failure(ApiError.decoding(error as? DecodingError)))
            }
        }
    }
    
    private func processAuthResponse<T: Codable>(_ type: T.Type, data: Data?, response: URLResponse?, error: Error?, completion: @escaping(Result<AuthResponse<T>, ApiError>) -> Void) {
        if let error = error as? URLError {
            // URLError
            completion(Result.failure(ApiError.url(error)))
        } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
            // Bad response
            completion(Result.failure(ApiError.badResponse(statusCode: response.statusCode)))
        } else if let data = data {
            do {
                let result = try JSONDecoder().decode(AuthResponse<T>.self, from: data)
                print("response------>")
                print(result)
                if result.success {
                    // Success
                    completion(Result.success(result))
                } else {
                    // Server side error
                    completion(Result.failure(ApiError.server(error: result.message)))
                }
            } catch {
                // Parse Error
                print(error)
                completion(Result.failure(ApiError.decoding(error as? DecodingError)))
            }
        }
    }
}
