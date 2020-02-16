//
//  ProfileRequestInterceptor.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 2/15/20.
//  Copyright © 2020 Spoohapps, Inc. All rights reserved.
//

import Foundation

import Alamofire

class ProfileRequestInterceptor : RequestInterceptor {
    
    private let lock = NSLock()
    
    let clientID: String
    var baseURLString: String
    var accessToken: String
    var refreshToken: String
    
    init(clientID: String, baseURLString: String, accessToken: String, refreshToken: String) {
        self.clientID = clientID
        self.baseURLString = baseURLString
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        urlRequest.headers.add(.authorization(bearerToken: accessToken))

        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        lock.lock() ; defer { lock.unlock() }
        
        
    }
    
}
