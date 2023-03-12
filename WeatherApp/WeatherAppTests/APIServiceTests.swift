//
//  APIServiceTests.swift
//  WeatherAppTests
//
//  Created by Fraghaly on 12/03/2023.
//

import XCTest
@testable import WeatherApp

class APIServiceTests: XCTestCase {
    var sut: WeatherServiceImpl?
    override func setUp() {
        super.setUp()
        sut = WeatherServiceImpl()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_fetch_forecast() {

        // Given A apiservice
        let sut = self.sut!

        // When fetch popular photo
        let expect = XCTestExpectation(description: "callback")

        sut.getWeather(loc:"London"){[weak self] result in
            guard let self = self else {
                return
            }
            expect.fulfill()
            switch result {
            case .success(let data):
               XCTAssertNotNil(data)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            self.wait(for: [expect], timeout: 3.1)
    }
}
}
