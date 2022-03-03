//
//  FlickrViewModel.swift
//  FlickrImageApp
//
//  Created by sonam taya on 2/3/22.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func fetchDidSucceed()
    func fetchDidFail(with title: String, description: String)
}

final class FlickrViewModel {
   
    init(delegate: ViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Variables and Properties
    private weak var delegate: ViewModelDelegate?
    var apiClient = APIClient()
    var data: FlickrDataModel? = nil
    
    // MARK: - Fetch Data
    
    func fetchData(with urlString: String) {
        let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: encodedUrlString ?? "kittens")
        apiClient.fetch(with: url, dataType: FlickrDataModel.self) { result in
            switch result {
            case .success(let response):
                // Perform on main thread to update UI
                print(response)

                DispatchQueue.main.async {
                    self.data = response
                    self.delegate?.fetchDidSucceed()
                }
            case .failure(let error):
                // Perform on main thread to update UI
                DispatchQueue.main.async {
                    self.delegate?.fetchDidFail(with: error.reason, description: error.localizedDescription)
                }
            }
        }
    }
    
    
}
