//
//  ContentView.swift
//  superheros_socal
//
//  Created by Steven Burrows on 12/06/2020.
//  Copyright © 2020 Steven Burrows. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    private let profilesURL = URL(string: "https://gist.githubusercontent.com/isaacmendez/32456d8c977c0aa1db5e9cd1b9abde08/raw/0dad70f71753f870c73e54160eb221ee52458e63/Profiles")!

    
    // optional profile - we know it will exist but not right away
    @State var profiles: [Profile] = []

    var body: some View {
    
    NavigationView {
        
        List {
            
            ForEach(profiles, id: \.self) { profile in
                NavigationLink (destination: ProfileView(profile: profile)) {
                               Text(profile?.userName ?? "No Name")
                                
                           }
            }
            
           
                 
             }
            .onAppear(perform: self.loadProfile)
            .navigationBarTitle("Super Hero Social")
        }
    }
 
    
    func loadProfile() {
        //URL Request
        let request = URLRequest(url: profilesURL)
        
        URLSession.shared.dataTask(with: request) { data, responce, error in
            // if we have data unwrp it and pass it in - else bail
            if let data = data {
                // use the data to try and make it into a Profile model - else bail
                // self is just a snapshot
                if let profiles = try? JSONDecoder().decode([Profile].self, from: data) {
                   // Store the profile to show it later
                    withAnimation {
                   self.profiles = profiles
                    }
                }
            }
            
            
        }
    .resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
