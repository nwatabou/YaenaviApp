//
//  AneiKankouApi.swift
//  
//
//  Created by nakanishi wataru on 2021/12/30.
//

import Foundation
import Kanna

public final class AneiKankouApi: FerryApiProtocol {
    private enum Const {
        static let aneiKankouDataUrlString = "https://aneikankou.co.jp/condition"
    }

    public func fetchRouteStatuses(
        success: @escaping (RouteStatusListResponse) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        guard let aneiKankouUrl = URL(string: Const.aneiKankouDataUrlString) else {
            // TODO: do failure closure
            return
        }

        let task = URLSession.shared.dataTask(with: aneiKankouUrl) { data, response, error in
            if let error = error {
                failure(error)
                return
            }

            guard let data = data,
                let html = try? HTML(html: data, encoding: .utf8) else {
                    // TODO: do failure closure
                    return
            }

            let infoText = html.xpath("//div[@class='condition_item_caution']").first?.content
            let routeStatuses: [RouteStatusResponse] = html
                .xpath("//div[@class='condition_item_btn']/a")
                .compactMap { routeStatus in
                    guard let routeName = routeStatus.content else {
                        return nil
                    }

                    switch routeStatus.className {
                    case "operation_normal":
                        return .init(
                            name: routeName,
                            status: "normal"
                        )

                    case "operation_suspension":
                        return .init(
                            name: routeName,
                            status: "suspension"
                        )

                    // TODO: add status

                    default:
                        return nil
                    }
                }

            let routeStatusList: RouteStatusListResponse = .init(
                info: infoText,
                routeStatuses: routeStatuses
            )

            success(routeStatusList)
        }

        task.resume()
    }

    public func fetchRouteScheduleList(
        success: @escaping ([RouteScheduleListResponse]) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        guard let aneiKankouUrl = URL(string: Const.aneiKankouDataUrlString) else {
            // TODO: do failure closure
            return
        }

        let task = URLSession.shared.dataTask(with: aneiKankouUrl) { data, response, error in
            if let error = error {
                failure(error)
                return
            }

            guard let data = data,
                let html = try? HTML(html: data, encoding: .utf8) else {
                    // TODO: do failure closure
                    return
            }

            let routeScheduleList: [RouteScheduleListResponse] = html
                .xpath("//div[@class='condition_item']")
                .compactMap { route in
                    let outwardRouteIndex: Int = 0
                    let returnRouteIndex: Int = 1

                    guard let routeName = route.xpath("div[@class='condition_item_title']").first?.content,
                          let outwardRouteName = route.xpath("div[@class='condition_item_detail flexbox']/div[@class='condition_item_port_title']")[outwardRouteIndex].content,
                          let returnRouteName = route.xpath("div[@class='condition_item_detail flexbox']/div[@class='condition_item_port_title']")[returnRouteIndex].content else {
                              return nil
                          }

                    var outwardSchedules: [RouteScheduleResponse] = []
                    var returnSchedules: [RouteScheduleResponse] = []
                    route.xpath("div[@class='flexbox']/div[@class='condition_item_port_detail']")
                        .enumerated()
                        .forEach { index, scheduleList in
                            scheduleList.xpath("div[@class='flexbox']")
                                .forEach { schedule in
                                    switch index {
                                    case outwardRouteIndex:
                                        guard let time = schedule.xpath("div[@class='condition_item_port_detail_time']").first?.content,
                                              let statusMark = schedule.xpath("div[@class='condition_item_port_detail_status']").first?.content else { return }
                                        outwardSchedules.append(
                                            .init(
                                                time: time,
                                                status: statusMark
                                            )
                                        )
                                    case returnRouteIndex:
                                        guard let time = schedule.xpath("div[@class='condition_item_port_detail_time']").first?.content,
                                              let statusMark = schedule.xpath("div[@class='condition_item_port_detail_status']").first?.content else { return }
                                        returnSchedules.append(
                                            .init(
                                                time: time,
                                                status: statusMark
                                            )
                                        )
                                    default:
                                        return
                                    }
                                }
                        }

                    return .init(
                        name: routeName,
                        outwardRouteName: outwardRouteName,
                        outwardRouteSchedules: outwardSchedules,
                        returnRouteName: returnRouteName,
                        returnRouteSchedules: returnSchedules
                    )
            }

            success(routeScheduleList)
        }

        task.resume()
    }
}
