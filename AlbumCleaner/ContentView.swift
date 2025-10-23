//
//  ContentView.swift
//  AlbumCleaner
//
//  Created by 泉知成 on 2025/10/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            NavigationStack {
                NavigationLink(destination: SwipeCardDemo()) {
                    Text("次のページ")
                }
            }
        }
    }
}

#Preview {
    SwipeCardDemo()
}


struct SwipeCardDemo: View {
    @State private var numbers = [2, 1, 0]
    @State private var translation: CGSize = .zero
    
    var body: some View {
        GeometryReader { (proxy: GeometryProxy) in
            ZStack {
                let ScreenWidth = proxy.size.width
                let ScreenHeight = proxy.size.height
                
                ForEach(self.numbers, id: \.self) {(i: Int) in
                    Text("Number \(i)")
                        .font(.title)
                        .frame(width: ScreenWidth - 16 * 2, height: ScreenHeight - 16 * 3, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .scaleEffect(pow(0.9, CGFloat(i)))
                        .offset(self.numbers.last == i ? self.translation : .zero)
                        .gesture(
                            DragGesture()
                                .onChanged({ self.translation = $0.translation })
                                .onEnded({ _ in
                                    self.numbers.removeLast()
                                    self.translation = .zero
                                })
                        )
                        .rotationEffect(.degrees(Double(self.translation.width / 300) * 25), anchor: .bottom)
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}
