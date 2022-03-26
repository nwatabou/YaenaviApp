//
//  FerryRouteListViewModel.swift
//  
//
//  Created by nakanishi wataru on 2022/03/26.
//

import Combine
import Foundation

import AppCore

final class FerryRouteListViewModel: ObservableObject {
    private(set) var action = Action()

    @Published
    private(set) var state: State

    var cancellables = Set<AnyCancellable>()

    init(
        state: State,
        dependency: Dependency
    ) {
        self.state = state

        let innerAction = InnerAction()

        innerAction
            .fetchFerryroute
            .flatMap {
                dependency
                    .ferryRouteRepository
                    .fetchFerryRoute()
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    // TODO: error handling
                    break
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.state.routeList = response
            })
            .store(in: &cancellables)

        action
            .onAppear
            .sink(receiveValue: {
                innerAction.fetchFerryroute.send()
            })
            .store(in: &cancellables)

        action
            .pullToRefresh
            .sink(receiveValue: {
                innerAction.fetchFerryroute.send()
            })
            .store(in: &cancellables)
    }

    fileprivate struct InnerAction {
        let fetchFerryroute = PassthroughSubject<Void, Never>()
    }

    struct State {
        fileprivate(set) var routeList: [FerryRouteViewData] = []
    }

    struct Dependency {
        let ferryRouteRepository: FerryRouteRepositoryProtocol
    }

    struct Action {
        let onAppear = PassthroughSubject<Void, Never>()
        let pullToRefresh = PassthroughSubject<Void, Never>()
        let tapRoute = PassthroughSubject<RouteStatusResponse, Never>()
    }
}
