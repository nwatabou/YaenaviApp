//
//  AnkeiKankouApiTests.swift
//  
//
//  Created by nakanishi wataru on 2021/12/30.
//

import XCTest
@testable import API

class AnkeiKankouApiTests: XCTestCase {
    private let aneiKankouApi: FerryApiProtocol = AneiKankouApi()

    func testFetchRouteStatuses() {
        let expectation = XCTestExpectation(description: "expect to fetch route statuses from Anei Kankou")

        aneiKankouApi.fetchRouteStatuses(
            success: { response in
                XCTAssertFalse(response.routeStatuses.isEmpty)
                expectation.fulfill()
            },
            failure: { error in
                XCTFail(error.localizedDescription)
                expectation.fulfill()
            })

        wait(for: [expectation], timeout: 10)
    }

    func testFetchRouteScheduleList() {
        let expectation = XCTestExpectation(description: "expect to fetch route schedules from Anei Kankou")

        aneiKankouApi.fetchRouteScheduleList(
            success: { response in
                XCTAssertFalse(response.isEmpty)
                XCTAssertFalse(response.first?.outwardRouteSchedules.isEmpty ?? true)
                XCTAssertFalse(response.first?.returnRouteSchedules.isEmpty ?? true)
                expectation.fulfill()
            },
            failure: { error in
                XCTFail(error.localizedDescription)
                expectation.fulfill()
            })

        wait(for: [expectation], timeout: 10)
    }
}
