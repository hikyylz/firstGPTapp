//
//  OpenAIService.swift
//  firstGPTapp
//
//  Created by Kaan Yıldız on 22.01.2024.
//

// https://www.youtube.com/watch?v=WNBPFYWuPHo

import Foundation
import Alamofire

class OpenAIService {
    private let endPointURL: String = "https://api.openai.com/v1/chat/completions"
    
    func sendMessage(messages: [Message]) async -> OpenAIChatResponse? {
        
        // kullanıcı mesage ını gpt için uygun formda olacak şekilde openaımessage dizisine map liyorum.
        // .map({ ... }) mevcut dizideki her elemana işlem uygula yerine yazma işlemini yapıyo.
        let openAImessages = messages.map({ OpenAIChatMessage(role: $0.role, content: $0.content) })
        let body = OpenAIChatBody(model: "gpt-3.5-turbo", messages: openAImessages)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Constants.apiKey)"
        ]
        return try? await AF.request(endPointURL, method: .post, parameters: body, encoder: .json, headers:              headers).serializingDecodable(OpenAIChatResponse.self).value
    }
}

struct OpenAIChatBody: Codable {
    let model: String
    let messages: [OpenAIChatMessage]
}

struct OpenAIChatMessage : Codable{
    let role: SenderRole
    let content: String
}

enum SenderRole : String, Codable {
    case system
    case user
    case assistant
}


struct OpenAIChatResponse: Decodable {
    let choices: [OpenAIChatChoice]
}

struct OpenAIChatChoice: Decodable {
    let message: OpenAIChatMessage
}
