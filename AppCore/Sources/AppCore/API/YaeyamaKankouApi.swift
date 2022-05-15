//
//  YaeyamaKankouApi.swift
//  
//
//  Created by nakanishi wataru on 2022/03/06.
//

import Foundation
import Kanna

public final class YaeyamaKankouApi: FerryApiProtocol {
    private enum Const {
        static let yaeyamaKankouStatusDataUrlString = "https://www.yaeyama.co.jp/index.html"
        static let yaeyamaKankouScheduleDataUrlString = "https://www.yaeyama.co.jp/operation.html"
        static let normalStatusMark = "〇"
        static let cancellationStatusMark = "×"
    }

    public init() {}

    public func fetchRouteStatuses(
        completion: @escaping (Result<RouteStatusListResponse, Error>) -> Void
    ) {
        guard let yaeyamaKankouUrl = URL(string: Const.yaeyamaKankouStatusDataUrlString) else {
            // TODO: do failure closure
            return
        }

        let task = URLSession.shared.dataTask(with: yaeyamaKankouUrl) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data,
                let html = try? HTML(html: data, encoding: .utf8) else {
                    // TODO: do failure closure
                    return
            }

            let infoText = html.xpath("//div[@class='statuscomment']").first?.content
            let routeStatuses: [RouteStatusResponse] = html
                .xpath("//div[contains(@class, 'kouro')]")
                .compactMap { routeStatus in
                    guard let content = routeStatus.content else {
                        return nil
                    }
                    if content.contains(Const.normalStatusMark) {
                        let routeName = routeStatus.content?
                            .replacingOccurrences(of: Const.normalStatusMark, with: "") ?? ""
                        return RouteStatusResponse(
                            name: routeName,
                            status: "normal"
                        )
                    } else if content.contains(Const.cancellationStatusMark) {
                        let routeName = routeStatus.content?
                            .replacingOccurrences(of: Const.normalStatusMark, with: "") ?? ""
                        return RouteStatusResponse(
                            name: routeName,
                            status: "suspension"
                        )
                    } else {
                        return nil
                    }
                    // TODO: add other status
                }
            let response = RouteStatusListResponse(
                info: infoText,
                routeStatuses: routeStatuses
            )
            completion(.success(response))
        }
        task.resume()
    }

    public func fetchRouteScheduleList(
        routePrefix: String,
        completion: @escaping (Result<RouteScheduleListResponse, Error>) -> Void
    ) {
        guard let url = URL(string: Const.yaeyamaKankouScheduleDataUrlString) else {
            // TODO: do failure closure
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                // TODO: do failure closure
                return
            }
            guard let html = try? HTML(html: data, encoding: .utf8) else { return }
            let routes: [RouteScheduleListResponse] = html
                .xpath("//div[@class='local']/table")
                .compactMap { table -> RouteScheduleListResponse? in
                    var routeName: String = table.xpath("/thble/h3").first?.content ?? ""
                    var outwardRouteName: String = ""
                    var outwardSchedules: [RouteScheduleResponse] = []
                    var returnRouteName: String = ""
                    var returnRouteSchedules: [RouteScheduleResponse] = []

                    // get port name for route
                    table
                        .xpath("/tr")
                        .forEach { tr in
                            tr
                                .xpath("/td[contains(text(), '発')]")
                                .enumerated()
                                .forEach { index, portName in
                                    switch index {
                                    case 0:
                                        outwardRouteName = portName.content ?? ""
                                    case 1:
                                        returnRouteName = portName.content ?? ""
                                    default:
                                        return
                                    }
                                }
                        }

                    // get time schedule
                    table
                        .xpath("/tr")
                        .forEach { tr in
                            tr
                                .xpath("/td[contains(@class, 'th')]")
                                .enumerated()
                                .forEach { index, timeSchedule in
                                    guard let text = timeSchedule.content?.components(separatedBy: " ") else {
                                        return
                                    }
                                    let statusMark = text[0]
                                    let timeText = text[1]
                                    switch index {
                                    case 0:
                                        outwardSchedules.append(
                                            .init(
                                                time: timeText,
                                                status: statusMark
                                            )
                                        )

                                    case 1:
                                        returnRouteSchedules.append(
                                            .init(
                                                time: timeText,
                                                status: statusMark)
                                        )

                                    default:
                                        return
                                    }
                                }
                        }

                    return RouteScheduleListResponse(
                        name: routeName,
                        outwardRouteName: outwardRouteName,
                        outwardRouteSchedules: outwardSchedules,
                        returnRouteName: returnRouteName,
                        returnRouteSchedules: returnRouteSchedules
                    )
            }
            guard let route = routes.first(where: { $0.name.contains(routePrefix) }) else {
                // TODO: do failure closure
                return
            }
            completion(.success(route))
        }
        task.resume()
    }
}
