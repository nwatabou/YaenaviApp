//
//  FerryScheduleListViewModel.swift
//  
//
//  Created by nakanishi wataru on 2022/05/15.
//

import Combine
import Foundation

import AppCore
import Parchment

final class FerryScheduleListViewModel: ObservableObject {
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
            .fetchSchedules
            .flatMap {
                dependency
                    .ferryScheduleRepository
                    .fetchSchedule(routePrefix: dependency.routePrefix)
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
                self?.state.pagingItems.append(PagingIndexItem(index: 0, title: response.outwardRouteSchedule.portName))
                self?.state.pagingItems.append(PagingIndexItem(index: 1, title: response.returnRouteSchedule.portName))
                self?.state.outwardRouteSchedules = response.outwardRouteSchedule.schedules
                self?.state.returnRouteSchedules = response.returnRouteSchedule.schedules
            })
            .store(in: &cancellables)

        action
            .onAppear
            .sink(receiveValue: {
                innerAction.fetchSchedules.send()
            })
            .store(in: &cancellables)

        action
            .onDisappear
            .sink(receiveValue: { [weak self] in
                self?.state.pagingItems = []
                self?.state.outwardRouteSchedules = []
                self?.state.returnRouteSchedules = []
            })
            .store(in: &cancellables)

        action
            .pullToRefresh
            .sink(receiveValue: {
                innerAction.fetchSchedules.send()
            })
            .store(in: &cancellables)
    }

    fileprivate struct InnerAction {
        let fetchSchedules = PassthroughSubject<Void, Never>()
    }

    struct State {
        fileprivate(set) var pagingItems: [PagingIndexItem] = []
        fileprivate(set) var outwardRouteSchedules: [FerryScheduleViewData] = []
        fileprivate(set) var returnRouteSchedules: [FerryScheduleViewData] = []
    }

    struct Dependency {
        let routePrefix: String
        let ferryScheduleRepository: FerryScheduleRepositoryProtocol
    }

    struct Action {
        let onAppear = PassthroughSubject<Void, Never>()
        let onDisappear = PassthroughSubject<Void, Never>()
        let pullToRefresh = PassthroughSubject<Void, Never>()
    }
}
