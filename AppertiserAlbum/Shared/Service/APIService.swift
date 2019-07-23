//
//  Wash8APIService.swift
//  Wash8
//
//  Created by Ella on 20/07/2019.
//  Copyright © 2019 Ella. All rights reserved.
//

import Foundation
import Moya

private let baseUrl: String = ConfigurationProvider.apiBaseUrl

let endpointClosure = { (target: APIService) -> Endpoint in
    let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
    #if DEBUG
    print("\n\n****************** API Call *********************")
    print("base url:  \(target.baseURL)")
    print("\nurl: \(defaultEndpoint.url)")
    print("\ntarget \(target)")
    print("\ntarget headers \(String(describing: target.headers))")
    print("\ntarget task \(target.task)")
    print("\ntarget method \(target.method)")
    print("\n****************** API Call *********************\n\n")
    #endif
    return defaultEndpoint
}

let APIProvider = MoyaProvider<APIService>(endpointClosure: endpointClosure,
                                           plugins: [NetworkLoggerPlugin(verbose: true)])

enum APIService {
    case list(ListRequest)
    case details
}

extension APIService: TargetType, AccessTokenAuthorizable {

    var baseURL: URL {
        return URL(string: baseUrl) ?? URL(fileURLWithPath: baseUrl)
    }

    var path: String {
        switch self {
        case .list:
            return "search"
        default:
            return "lookup"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .list(let request):
            let parameters = ["term": request.term,
                              "country": request.country,
                              "media": request.media]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)

        case .details:
            return .requestParameters(parameters: ["":""], encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return nil
    }

    var authorizationType: AuthorizationType {
        return .none
    }

    var validate: Bool {
        return true
    }
}

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}
