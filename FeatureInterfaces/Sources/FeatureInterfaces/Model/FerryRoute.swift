//
//  FerryRoute.swift
//  
//
//  Created by nakanishi wataru on 2022/04/10.
//

import Foundation

public enum FerryRoute {
    case taketomi
    case kohama
    case kuroshima
    case oohara
    case uehara
    case hatoma
    case hateruma

    public var sortOrder: Int {
        switch self {
        case .taketomi: return 0
        case .kohama: return 1
        case .kuroshima: return 2
        case .oohara: return 3
        case .uehara: return 4
        case .hatoma: return 5
        case .hateruma: return 6
        }
    }

    public var displayName: String {
        switch self {
        case .taketomi:
            return "竹富航路"
        case .kohama:
            return "小浜航路"
        case .kuroshima:
            return "黒島航路"
        case .oohara:
            return "西表大原航路"
        case .uehara:
            return "西表上原航路"
        case .hatoma:
            return "鳩間航路"
        case .hateruma:
            return "波照間航路"
        }
    }

    public init?(rawValue: String) {
        switch rawValue {
        case _ where rawValue.contains("竹富"):
            self = .taketomi
        case _ where rawValue.contains("小浜"):
            self = .kohama
        case _ where rawValue.contains("黒島"):
            self = .kuroshima
        case _ where rawValue.contains("大原"):
            self = .oohara
        case _ where rawValue.contains("上原"):
            self = .uehara
        case _ where rawValue.contains("鳩間"):
            self = .hatoma
        case _ where rawValue.contains("波照間"):
            self = .hateruma
        default:
            return nil
        }
    }
}
