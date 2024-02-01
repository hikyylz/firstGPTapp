//
//  EntryOfApp.swift
//  firstGPTapp
//
//  Created by Kaan Yıldız on 31.01.2024.
//

import SwiftUI

struct EntryOfAppView: View {
    private let SizeOfBox: CGFloat = 150
    private let linkColumns : [GridItem] = [
        GridItem(.adaptive(minimum: 150, maximum: 150), spacing: 10),
        GridItem(.adaptive(minimum: 150, maximum: 150), spacing: 10)
            
    ]
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Please select types of Ai you want to talk")
                    .font(.headline)
                    .padding()
                ScrollView{
                    LazyVGrid(columns: linkColumns, content: {
                        navigationLinkView(behaviourDescription.friendlyDescription, DisplayText: "acts friendly", color: .blue)
                        navigationLinkView(behaviourDescription.formalDescription, DisplayText: "acts formal", color: .brown)
                        navigationLinkView(behaviourDescription.animeDescription, DisplayText: "acts anime char", color: .brown)
                        navigationLinkView(behaviourDescription.jamesBondDescription, DisplayText: "acts like james bond", color: .blue)
                        navigationLinkView(behaviourDescription.zekiMurenDescription, DisplayText: "acts like zeki müren", color: .blue)
                    })
                    

                }
            }
            .navigationTitle("gpt talking app")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func navigationLinkView(_ behaviourDescription: String, DisplayText: String, color: Color) -> some View{
        NavigationLink {
            ChatView(behaviour: behaviourDescription)
        } label: {
            RoundedRectangle(cornerRadius: 25.0)
                .frame(width: SizeOfBox, height: SizeOfBox)
                .foregroundColor(color)
                .overlay {
                    Text(DisplayText)
                        .foregroundStyle(.black)
                }
        }
    }
}

#Preview {
    EntryOfAppView()
}
