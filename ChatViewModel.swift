//
//  ChatViewModel.swift
//  firstGPTapp
//
//  Created by Kaan Yıldız on 22.01.2024.
//

import Foundation

class ChatViewModel: ObservableObject{
    @Published var messages: [Message] = []
    @Published var currentInput: String = ""
    private let behaviourType : String
    private let openAiService = OpenAIService()
    
    init(behaviourDescription : String){
        self.behaviourType = behaviourDescription
    }
    
    func removeFirstPromt(){
        messages = []
    }
    
    func confirmFirstPromt(){
        // ilk komutum burada gönderilecek ve bu komut messages dizisine eklenmeyecek.
        let newMassage = Message(id: UUID(), role: .user, content: behaviourType, createAt: Date())
        Task{
            let response = await openAiService.sendMessage(messages: [newMassage])
            guard let openAiResponse = response?.choices.first?.message else{
                print("had no recieved while first input")
                return
            }
            let resievedMessage = Message(id: UUID(), role: .assistant, content: openAiResponse.content, createAt: Date())
            await MainActor.run {
                messages.append(resievedMessage)
            }
        }
    }
    
    func sendMessage(){
        let newMassage = Message(id: UUID(), role: .user, content: currentInput, createAt: Date())
        messages.append(newMassage)
        currentInput = ""
        
        Task{
            let response = await openAiService.sendMessage(messages: messages)
            guard let openAiResponse = response?.choices.first?.message else{
                print("had no recieved")
                return
            }
            let resievedMessage = Message(id: UUID(), role: .assistant, content: openAiResponse.content, createAt: Date())
            await MainActor.run {
                messages.append(resievedMessage)
            }
        }
    }
}

enum behaviourType: String{
    case actFriendly
    case actFormal
    case actAnime
    case actJamesBond
    case actZekiMuren
}

struct Message: Decodable {
    let id: UUID
    let role: SenderRole
    let content: String
    let createAt: Date
}
