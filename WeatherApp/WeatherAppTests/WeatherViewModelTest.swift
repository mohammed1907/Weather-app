//
//  WeatherViewModelTest.swift
//  WeatherAppTests
//
//  Created by Fraghaly on 12/03/2023.
//

import XCTest
@testable import WeatherApp

class WeatherViewModelTest: XCTestCase {
    var sut: WeatherViewModelLogic!
    var apiServiceMock: ApiServiceMock!
    override func setUp() {
        super.setUp()
        apiServiceMock = ApiServiceMock()
        sut = WeatherViewModel(apiService: apiServiceMock)
    }
    override func tearDown() {
        sut = nil
        apiServiceMock = nil
        super.tearDown()
    }
    func test_fetch_weather() {
        // Given
        apiServiceMock.isFetchDataCalled = false

        // When
        sut.getWeather(name:"London")

        // Assert
        XCTAssert(apiServiceMock!.isFetchDataCalled)
    }
    func test_loading_state_when_fetching() {
        // Given
        var state: State = .empty
        let expect = XCTestExpectation(description: "Loading state updated to populated")
        sut.updateLoadingStatus = {
            state = self.sut!.state
            expect.fulfill()
        }
        // when fetching
        sut.getWeather(name: "London")
        // Assert
        XCTAssertEqual(state, State.loading)
        wait(for: [expect], timeout: 1.0)
    }
}
