//
//  ContentView.swift
//  10Minute
//
//  Created by Lichen Ma on 2022/5/9.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var sceneDelegate: SceneDelegate
    var body: some View {
        VStack {
            Text("\(sceneDelegate.minutes):\(sceneDelegate.seconds)").font(.system(size:40))
            Text("Streak: \(sceneDelegate.streak)").font(.system(size:20))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
