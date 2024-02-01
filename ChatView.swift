//
//  ContentView.swift
//  firstGPTapp
//
//  Created by Kaan Yıldız on 22.01.2024.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var chatviewModel : ChatViewModel
    private var navigationTitle: String = "Ai model"
    
    init(behaviour: String) {
        self.chatviewModel = ChatViewModel(behaviourDescription: behaviour)
    }
    
    var body: some View {
        NavigationStack{
            VStack {
                ScrollView{
                    ForEach(chatviewModel.messages.filter({$0.role != .system}), id: \.id) { message in
                        massageView(message)
                    }
                }
                .padding()
                
                HStack{
                    TextField("enter a message", text: $chatviewModel.currentInput)
                    Button("send") {
                        chatviewModel.sendMessage()
                    }
                }
            }
            .padding()
            
            .navigationTitle(self.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
        .onDisappear(perform: {
            chatviewModel.removeFirstPromt()
        })
        .onAppear {
            chatviewModel.confirmFirstPromt()
        }
    }
    
    func massageView(_ message: Message) -> some View{
        HStack{
            if message.role == .user{
                Spacer()
            }
            Text(message.content)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius:10.0)
                        .fill(message.role == .user ? .blue : .gray)
                )
            if message.role == .assistant{
                Spacer()
            }
        }
    }
}



//#Preview {
//    ChatView()
//}
