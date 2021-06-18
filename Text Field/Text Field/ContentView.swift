//
//  ContentView.swift
//  Text Field
//
//  Created by Nerimene on 28/5/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var tfManager = TextFieldManager()
    @State var isTapped = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 4, content: {
                HStack(spacing: 15) {
                    TextField("", text: $tfManager.txt) { (status) in
                        if status {
                            withAnimation(.easeIn) {
                                isTapped = true
                            }
                        }
                    } onCommit: {
                        if tfManager.txt == "" {
                            withAnimation(.easeOut) {
                                isTapped = false
                            }
                        }
                    }
                    Image(systemName: isTapped ? "person.crop.circle.fill.badge.checkmark" : "person.crop.circle.fill.badge.xmark")
                        .foregroundColor(.gray)
                }.padding(.top, isTapped ? 15 : 0)
                .background(
                    Text("User Name")
                        .scaleEffect(isTapped ? 0.8 : 1)
                        .offset(x: isTapped ? -7 : 0, y: isTapped ? -15 : 0)
                        .foregroundColor(isTapped ? .accentColor : .gray)
                    ,alignment: .leading
                ).padding(.horizontal)
                Rectangle()
                    .fill(isTapped ? Color.accentColor : Color.gray)
                    .opacity(isTapped ? 1 : 0.5)
                    .frame(height: 1)
                    .padding(.top, 10)
            }).padding(.top, 12)
            .background(Color.gray.opacity(0.09))
            .cornerRadius(5)
            
            HStack {
                Spacer()
                Text("\(tfManager.txt.count)/12")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.trailing)
                    .padding(.top, 4)
            }
        }.padding()
    }
}

class TextFieldManager: ObservableObject {
    @Published var txt = "" {
        didSet {
            if txt.count > 12 && oldValue.count <= 12 {
                txt = oldValue
            }
        }
    }
}
