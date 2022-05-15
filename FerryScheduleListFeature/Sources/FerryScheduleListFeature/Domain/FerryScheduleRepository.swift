//
//  FerryScheduleRepository.swift
//  
//
//  Created by nakanishi wataru on 2022/05/05.
//

import Combine
import Foundation

import AppCore
import FeatureInterfaces

protocol FerryScheduleRepositoryProtocol {
    func fetchSchedule(
        routePrefix: String
    ) -> AnyPublisher<FerryScheduleListViewData, Error>
}

final class FerryScheduleRepository: FerryScheduleRepositoryProtocol {
    private let aneiKankouApi: FerryApiProtocol
    private let yaeyamaKankouApi: FerryApiProtocol

    init(
        aneiKankouApi: FerryApiProtocol,
        yaeyamaKankouApi: FerryApiProtocol
    ) {
        self.aneiKankouApi = aneiKankouApi
        self.yaeyamaKankouApi = yaeyamaKankouApi
    }

    func fetchSchedule(
        routePrefix: String
    ) -> AnyPublisher<FerryScheduleListViewData, Error> {
        fetchAneiKankouSchedule(routePrefix: routePrefix)
            .map { aneiKankouSchedule -> FerryScheduleListViewData in
                let aneiKankouOutwardSchedules = FerryScheduleListTranslator.translateToFerrySchedules(
                    from: aneiKankouSchedule.outwardRouteSchedules,
                    company: .aneiKankou
                )
                let aneiKankouReturnSchedules = FerryScheduleListTranslator.translateToFerrySchedules(
                    from: aneiKankouSchedule.returnRouteSchedules,
                    company: .aneiKankou
                )

                return FerryScheduleListViewData(
                    name: aneiKankouSchedule.name,
                    dateString: "", // TODO:
                    statusInfo: "", // TODO:
                    outwardRouteSchedule:.init(
                            portName: aneiKankouSchedule.outwardRouteName,
                            schedules: aneiKankouOutwardSchedules
                        ),
                    returnRouteSchedule: .init(
                        portName: aneiKankouSchedule.returnRouteName,
                        schedules: aneiKankouReturnSchedules
                    )
                )
            }
            .eraseToAnyPublisher()
    }
}

extension FerryScheduleRepository {
    private func fetchAneiKankouSchedule(
        routePrefix: String
    ) -> AnyPublisher<RouteScheduleListResponse, Error> {
        Deferred {
            Future<RouteScheduleListResponse, Error> { [weak self] promise in
                guard let self = self else { return }

            self.aneiKankouApi
                .fetchRouteScheduleList(
                    routePrefix: routePrefix,
                    completion: { result in
                        switch result {
                        case let .success(response):
                            promise(.success(response))
                        case let .failure(error):
                            promise(.failure(error))
                        }
                    }
                )
            }
        }
        .eraseToAnyPublisher()
    }

    private func fetchYaeyamaKankouSchedule(
        routePrefix: String
    ) -> AnyPublisher<RouteScheduleListResponse, Error>{
        Deferred {
            Future<RouteScheduleListResponse, Error> { [weak self] promise in
                guard let self = self else { return }

                self.yaeyamaKankouApi
                    .fetchRouteScheduleList(
                        routePrefix: routePrefix,
                        completion: { result in
                            switch result {
                            case let .success(response):
                                promise(.success(response))
                            case let .failure(error):
                                promise(.failure(error))
                            }
                        }
                    )
            }
        }
        .eraseToAnyPublisher()
    }
}
