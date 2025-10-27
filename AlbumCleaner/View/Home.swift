//
//  Home.swift
//  AlbumCleaner
//
//  Created by 泉知成 on 2025/10/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var homeData: HomeViewModel = HomeViewModel()
    var body: some View {
        VStack {
            Button {
            } label: {
                Image(systemName: "sun.haze.circle.fill")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(
                Text("AlubmCleaner")
                    .font(.title.bold())
            )
            .foregroundColor(.black)
            .padding()
            
            ZStack {
                
                if let users = homeData.displaying_users{
                    
                    if users.isEmpty{
                        Text("Complete to tidy up your photos!")
                            .font(.caption)
                            .foregroundColor(.gray)
                    } else {
                        ForEach(users.reversed()){ user in
                            StackCardView(user: user)
                                .environmentObject(homeData)
                        }
                    }
                } else {
                    ProgressView()
                }
            }
            .padding(.top, 30)
            .padding()
            .padding(.vertical)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            HStack(spacing: 15){
                Button {
                
                } label: {
                    Image(systemName: "arrow.uturn.backward")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .padding(13)
                        .background(Color.gray)
                        .clipShape(Circle())
                }
                
                Button {
                    doSwipe(rightSwipe: false)
                } label: {
                    Image(systemName: "trash")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding(18)
                        .background(Color.red)
                        .clipShape(Circle())
                }
                
                Button {
                
                } label: {
                    Image(systemName: "star.fill")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding(13)
                        .background(Color.yellow)
                        .clipShape(Circle())
                }
                
                Button {
                    doSwipe(rightSwipe: true)
                } label: {
                    Image(systemName: "forward.fill")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding(18)
                        .background(Color.green)
                        .clipShape(Circle())
                }
                
            }
            .padding(.bottom)
            .disabled(homeData.displaying_users?.isEmpty ?? false)
            .opacity((homeData.displaying_users?.isEmpty ?? false)
                     ? 0.6 : 1)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    func doSwipe(rightSwipe: Bool = false){
        guard let first = homeData.displaying_users?.first else {
            return
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("ACTIONFROMBUTTON"), object: nil, userInfo: ["id": first.id, "rightSwipe": rightSwipe]
        )
    }
}

#Preview {
    ContentView()
}
