//
//  ContentView.swift
//  WidgetKitDemo
//
//  Created by kuanwei on 2021/7/2.
//

import SwiftUI

struct ContentView: View {

    @State var pandaActive: Bool = false
    @State var spoutyActive: Bool = false
    @State var eggheadActive: Bool = false

    var body: some View {
        NavigationView {
            List {
                NavigationLink(
                    destination: DetailView(character: .panda), isActive: $pandaActive) {
                    TableRow(character: .panda)
                }
                NavigationLink(
                    destination: DetailView(character: .spouty), isActive: $spoutyActive) {
                    TableRow(character: .spouty)
                }
                NavigationLink(
                    destination: DetailView(character: .egghead), isActive: $eggheadActive) {
                    TableRow(character: .egghead)
                }
            }
            .onAppear() {
                if let character = CharacterDetail.getLastSelectedCharacter() {
                    print("Last character selection: \(character)")
                }
            }
            .navigationBarTitle("Your Characters")
            .onOpenURL(perform: { url in
                self.pandaActive = url == CharacterDetail.panda.url
                self.spoutyActive = url == CharacterDetail.spouty.url
                self.eggheadActive = url == CharacterDetail.egghead.url
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TableRow: View {
    let character: CharacterDetail

    var body: some View {
        HStack {
            Avatar(character: character)
            CharacterNameView(character)
                .padding()
        }
    }
}
