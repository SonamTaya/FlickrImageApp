//
//  TestValidApiCallReturns.swift
//  FlickrImageAppTests
//
//  Created by sonam taya on 3/3/22.
//

import XCTest

class TestValidApiCallReturns: XCTestCase {
    
    // System Under Test
    var sut: URLSession!
    
    override func setUp() {
      super.setUp()
      sut = URLSession(configuration: .default)
    }
    
    override func tearDown() {
      sut = nil
      super.tearDown()
    }
    
    // MARK: - Tests: API Call

    func testValidCallReturnsCompletion() {
        let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=96358825614a5d3b1a1c3fd87fca2b47&text=kittens&format=json&nojsoncallback=1")
        let promise = expectation(description: "Returns completion handler")
        
        var statusCode: Int?
        var responseError: Error?
        
        let dataTask = sut.dataTask(with: url!) { (data, response, error) in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    

}
