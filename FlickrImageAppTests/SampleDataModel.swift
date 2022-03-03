//
//  SampleDataModel.swift
//  FlickrImageAppTests
//
//  Created by sonam taya on 2/3/22.
//

import XCTest
@testable import FlickrImageApp

var sampleDataModel: FlickrDataModel{
  load("response")
}

func load<T: Decodable>(_ testFile: String) -> T {
    let bundle = Bundle(identifier: "com.FlickrImageAppTests")
    guard let dataFile = bundle?.url(forResource: testFile, withExtension: "json") else {
        fatalError("Failed to load test data \(testFile)")
    }
    do {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let data = try Data(contentsOf: dataFile)
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Failed to parse the sample data \(error.localizedDescription)")
    }
}
