//
//  FerryRoute.swift
//  
//
//  Created by nakanishi wataru on 2022/04/10.
//

import Foundation

/// 航路
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

    /// 各航路名の Prefix
    public var prefix: String {
        switch self {
        case .taketomi:
            return Const.taketomiPrefix
        case .kohama:
            return Const.kohamaPrefix
        case .kuroshima:
            return Const.kuroshimaPrefix
        case .oohara:
            return Const.ooharaPrefix
        case .uehara:
            return Const.ueharaPrefix
        case .hatoma:
            return Const.hatomaPrefix
        case .hateruma:
            return Const.haterumaPrefix
        }
    }

    public init?(rawValue: String) {
        switch rawValue {
        case _ where rawValue.contains(Const.taketomiPrefix):
            self = .taketomi
        case _ where rawValue.contains(Const.kohamaPrefix):
            self = .kohama
        case _ where rawValue.contains(Const.kuroshimaPrefix):
            self = .kuroshima
        case _ where rawValue.contains(Const.ooharaPrefix):
            self = .oohara
        case _ where rawValue.contains(Const.ueharaPrefix):
            self = .uehara
        case _ where rawValue.contains(Const.hatomaPrefix):
            self = .hatoma
        case _ where rawValue.contains(Const.haterumaPrefix):
            self = .hateruma
        default:
            return nil
        }
    }
}

extension FerryRoute {
    private enum Const {
        static let taketomiPrefix = "竹富"
        static let kohamaPrefix = "小浜"
        static let kuroshimaPrefix = "黒島"
        static let ooharaPrefix = "大原"
        static let ueharaPrefix = "上原"
        static let hatomaPrefix = "鳩間"
        static let haterumaPrefix = "波照間"
    }
}
