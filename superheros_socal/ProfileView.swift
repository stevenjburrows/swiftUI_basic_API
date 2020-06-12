//
//  ProfileView.swift
//  superheros_socal
//
//  Created by Steven Burrows on 12/06/2020.
//  Copyright © 2020 Steven Burrows. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
    var profile: Profile?
    @State var profileImage = UIImage()
    @State var hasImage = false
    
    var body: some View {
        VStack{
            
            if hasImage {
                Image(uiImage: profileImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 400)
                    .transition(.opacity)
            }
            Text(profile!.userName)
            Text("\(profile!.age)")
            Text(profile!.bio)
            
            
        }
        .onAppear(perform: downloadImage)
    }
    
    func downloadImage() {
        
        guard let profile = profile else {return}
        
        let imageRequest = URLRequest(url: profile.profilePhotoURL)
        
        URLSession.shared.dataTask(with: imageRequest) { data, response, error in
            guard let data = data else {return}
            
            // try and get an image
            if let profileImage = UIImage(data: data) {
                //This is not good - URL session in on a background thread
                DispatchQueue.main.async {
                    withAnimation {
                        self.profileImage = profileImage
                        self.hasImage = true
                    }
                }
                
            }
            
        }
        .resume()
    }
}
//
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
