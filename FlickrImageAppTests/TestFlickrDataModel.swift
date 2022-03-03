//
//  TestFlickrDataModel.swift
//  FlickrImageAppTests
//
//  Created by sonam taya on 3/3/22.
//

import XCTest
@testable import FlickrImageApp

class TestFlickrDataModel: XCTestCase {
    
    private struct ExpectedResults {
        static let photos = [Photos].self
    }

    private struct Photos {
        static let page = 1
        static let pages = 1214
        static let perpage = 100
        static let total = 121355
        static let photo = Photo.self
    }

   
    private struct Photo {
        static let id = "51913879019"
        static let owner = "192779777@N02"
        static let secret = "96f55dba09"
        static let server = "65535"
        static let farm = 66
        static let title = "“The amount of sleep required by the average person is five minutes more.” - Wilson Mizener"
        static let ispublic = 1
        static let isfriend = 0
        static let isfamily = 0
    }

    var sut : FlickrDataModel?
    
    override func setUp() {
        sut = sampleDataModel
    }
    
    override  func tearDown() {
        sut = nil
    }
    
    func testAirportResource() {
        XCTAssertEqual(sut?.photos?.photo?.first?.id, Photos.photo.id)
        XCTAssertEqual(sut?.photos?.photo?.first?.farm, Photos.photo.farm)
        XCTAssertEqual(sut?.photos?.photo?.first?.secret, Photos.photo.secret)
        XCTAssertEqual(sut?.photos?.photo?.first?.server, Photos.photo.server)
    }
    
}
