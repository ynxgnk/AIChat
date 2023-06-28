//
//  APICaller.swift
//  ChatAI
//
//  Created by Nazar Kopeika on 28.06.2023.
//

import OpenAISwift
import Foundation

final class APICaller {
    static let shared = APICaller()
    
    @frozen enum Constants {
        static let key = "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"
        
    }
    
    private var client: OpenAISwift?
    
    private init() {}
    
    public func setup() {
        let client = OpenAISwift(authToken: Constants.key)
    }
    
    public func getResponse(input: String, completion: @escaping (Result<String, Error>) -> Void) {
        client?.sendCompletion(with: input, model: .codex(.cushman), completionHandler: { result in
            switch result {
            case .success(let model):
                print(String(describing: model.choices))
                let output = model.choices?.first?.text ?? ""
                completion(.success(output))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
}
