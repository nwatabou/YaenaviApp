//
//  AneiKankouApiTests.swift
//  AppCore
//
//  Created by Wataru Nakanishi on 2025/10/26.
//

import Testing
@testable import AppCore

struct AneiKankouApiTests {
  let api = AneiKankouApi()

  @Test
  func test_fetchRouteStatuses() async throws {
    let response = try await api.fetchRouteStatuses()
    
    #expect(response.routeStatuses.count > 0, "運航状況が1つ以上取得できること")
    
    for routeStatus in response.routeStatuses {
      #expect(!routeStatus.name.isEmpty, "路線名が空でないこと")
      #expect(!routeStatus.status.isEmpty, "ステータスが空でないこと")
      #expect(["operation_normal", "operation_suspension", "operation_partial"].contains(routeStatus.status), 
              "ステータスが期待される値のいずれかであること")
    }
  }

  @Test
  func test_fetchRouteScheduleList() async throws {
    let response = try await api.fetchRouteScheduleList(routePrefix: "竹富")

    #expect(!response.name.isEmpty, "路線名が空でないこと")
    #expect(response.name.contains("竹富"), "指定したプレフィックスを含む路線名であること")
    #expect(!response.outwardRouteName.isEmpty, "往路名が空でないこと")
    #expect(!response.returnRouteName.isEmpty, "復路名が空でないこと")
    
    #expect(response.outwardRouteSchedules.count >= 0, "往路スケジュールが取得できること")
    #expect(response.returnRouteSchedules.count >= 0, "復路スケジュールが取得できること")
    
    for schedule in response.outwardRouteSchedules {
      #expect(!schedule.time.isEmpty, "往路の時刻が空でないこと")
      #expect(!schedule.status.isEmpty, "往路のステータスが空でないこと")
    }
    
    for schedule in response.returnRouteSchedules {
      #expect(!schedule.time.isEmpty, "復路の時刻が空でないこと")
      #expect(!schedule.status.isEmpty, "復路のステータスが空でないこと")
    }
  }
}
