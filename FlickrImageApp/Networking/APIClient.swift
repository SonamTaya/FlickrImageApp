//
//  APIClient.swift
//  FlickrImageApp
//
//  Created by sonam taya on 2/3/22.
//


import UIKit

var baseUrlString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=96358825614a5d3b1a1c3fd87fca2b47&format=json&nojsoncallback=1&text="


final class APIClient {

    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    // MARK: - Network Call
    
    func fetch<T: Decodable>(with url: URL?, dataType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {

        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion(.failure(.request))
                }
                return
            }
           
            // Check if http response is successful and data is safe
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
                let safeData = data
                else {
                    DispatchQueue.main.async {
                        completion(.failure(.unknown))
                    }
                    return
            }
            switch statusCode {
            case 200...299:
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase

                    let decodedData = try decoder.decode(dataType, from: safeData)

                    DispatchQueue.main.async {
                        completion(.success(decodedData))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(.decoding))
                    }
                }
            default :
                DispatchQueue.main.async {
                    completion(.failure(.network))
                }
                return
            }
        }
        dataTask.resume()
    }
}


