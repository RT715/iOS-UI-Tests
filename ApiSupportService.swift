//
//  SecondUserService.swift
//  OpenAppUITests
//
//  Created by Artem Vybornov on 18.08.2022.
//  Copyright © 2022 Open Technologies. All rights reserved.
//

import Foundation

enum CustomError: Error {
    case invalidUrl
    case noResponse
    case noData
}

struct Response: Decodable {
    let ids: [String]
}

struct Params: Codable {
    let objectValue: String
    let objectId: String?
    let userId: String
    let userName: String
    let chatsCount: Int
    let env: String
}

class ApiSupportService: NSObject, URLSessionDelegate {
    
    // MARK: - Serve actions
    
    enum ServerActions: String {
        case createPost
        case createComment
        case createDM
        case rejectComment
        case deleteComment
        case deleteDM
    }
    
    // MARK: - Private properties
    
    private var session: URLSession?
    
    // MARK: - init
    
    override init() {
        super.init()
        self.session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
    }
    
    //MARK: - Public methods
    
    func perform(
        action: ServerActions,
        objectName: String,
        objectId: String?,
        userId: String,
        userNickname: String) async throws -> String {
            
            guard let url = URL(string: "https://qa.letsopen.co:443?action=\(action.rawValue)") else { throw CustomError.invalidUrl }
            var request = URLRequest(url: url)
            
            let params = Params(
                objectValue: objectName,
                objectId: objectId,
                userId: userId,
                userName: userNickname,
                chatsCount: 1,
                env: "io"
            )
            
            let body = try JSONEncoder().encode(params)
            request.httpBody = body
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue(Credentials().token, forHTTPHeaderField: "Authorization")
            request.httpMethod = "POST"
            
            do {
                let (data, response) = try await session!.data(for: request)
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode <= 300 else {
                    throw CustomError.noResponse }
                let responseBody = try JSONDecoder().decode(Response.self, from: data)
                guard let itemId = responseBody.ids.first else { throw CustomError.noData }
                return itemId
            } catch {
                throw error
            }
        }
    
    @objc(URLSession:didReceiveChallenge:completionHandler:) public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.serverTrust == nil {
            completionHandler(.useCredential, nil)
        } else {
            let trust: SecTrust = challenge.protectionSpace.serverTrust!
            let credential = URLCredential(trust: trust)
            completionHandler(.useCredential, credential)
        }
    }
}
