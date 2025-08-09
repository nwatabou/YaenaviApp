//
//  FerryRouteRepository.swift
//  
//
//  Created by nakanishi wataru on 2022/03/26.
//

import Combine
import Foundation

import FeatureInterfaces
import AppCore

protocol FerryRouteRepositoryProtocol {
  func fetchFerryRoute() -> AnyPublisher<[FerryRouteViewData], Error>
}

final class FerryRouteRepository: FerryRouteRepositoryProtocol {
  private let aneiKankouApi: FerryApiProtocol
  private let yaeyamaKankouApi: FerryApiProtocol
  
  init(
    aneiKankouApi: FerryApiProtocol,
    yaeyamaKankouApi: FerryApiProtocol
  ) {
    self.aneiKankouApi = aneiKankouApi
    self.yaeyamaKankouApi = yaeyamaKankouApi
  }
  
  func fetchFerryRoute() -> AnyPublisher<[FerryRouteViewData], Error> {
    Publishers
      .Zip(
        fetchAneiKankouFerryRoute(),
        fetchYaeyamaKankouFerryRoute()
      )
      .map { aneiKankouRoute, yaeyamaKankouRoute -> [FerryRouteViewData] in
        let aneiKankouRoute_ = aneiKankouRoute
          .compactMap { route -> FerryRouteViewData? in
            guard let ferryRoute = FerryRoute(rawValue: route.name),
                  let status = FerryRouteStatus(rawValue: route.status) else {
              return nil
            }
            return FerryRouteViewData(route: ferryRoute, status: status)
          }
        let yaeyamaKankouRoute_ = yaeyamaKankouRoute
          .compactMap { route -> FerryRouteViewData? in
            guard let ferryRoute = FerryRoute(rawValue: route.name),
                  let status = FerryRouteStatus(rawValue: route.status) else {
              return nil
            }
            return FerryRouteViewData(route: ferryRoute, status: status)
          }
        var routeList = aneiKankouRoute_ + yaeyamaKankouRoute_
        // 重複を除外
        routeList = Array(Set(routeList))
        // 並べ替え
        routeList = routeList.sorted(by: { $0.route.sortOrder < $1.route.sortOrder })
        return routeList
      }
      .eraseToAnyPublisher()
  }
}

extension FerryRouteRepository {
  private func fetchAneiKankouFerryRoute() -> AnyPublisher<[RouteStatusResponse], Error> {
    return Deferred {
      Future<[RouteStatusResponse], Error> { [weak self] promise in
        guard let self = self else {
          return
        }
        
        self.aneiKankouApi
          .fetchRouteStatuses(
            completion: { result in
              switch result {
              case let .success(response):
                promise(.success(response.routeStatuses))
              case let .failure(error):
                promise(.failure(error))
              }
            }
          )
      }
    }
    .eraseToAnyPublisher()
  }
  
  private func fetchYaeyamaKankouFerryRoute() -> AnyPublisher<[RouteStatusResponse], Error> {
    return Deferred {
      Future<[RouteStatusResponse], Error> { [weak self] promise in
        guard let self = self else {
          return
        }
        
        self.aneiKankouApi
          .fetchRouteStatuses(
            completion: { result in
              switch result {
              case let .success(response):
                promise(.success(response.routeStatuses))
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
