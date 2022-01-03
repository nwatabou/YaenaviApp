//
//  YaeyamaKankouApiTests.swift
//  
//
//  Created by nakanishi wataru on 2021/12/31.
//

import XCTest
@testable import API

class YaeyamaKankouApiTests: XCTestCase {
    private let yaeyamaKankouApi: FerryApiProtocol = YaeyamaKankouApi()

    func testFetchRouteStatuses() {
        let expectation = XCTestExpectation(description: "expect to fetch route statuses from Yaeyama Kankou")

        yaeyamaKankouApi.fetchRouteStatuses(
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
        let expectation = XCTestExpectation(description: "expect to fetch route schedules from Yaeyama Kankou")

        yaeyamaKankouApi.fetchRouteScheduleList(
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
