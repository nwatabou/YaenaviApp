//
//  FerryScheduleRepository.swift
//  
//
//  Created by nakanishi wataru on 2022/05/05.
//

import Combine
import Foundation

import AppCore

protocol FerryScheduleRepositoryProtocol {

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
        Publishers
            .Zip(
                fetchAneiKankouSchedule(routePrefix: routePrefix),
                fetchYaeyamaKankouSchedule(routePrefix: routePrefix)
            )
            .map { aneiKankouSchedule, yaeyamaKankouSchedule -> [FerryScheduleViewData] in
                let _aneiKankouSchedule = aneiKankouSchedule
                    .compactMap { schedule -> FerryScheduleViewData in
                        
                    }
            }
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
