//
//  CharacterNameView.swift
//  WidgetKitDemo
//
//  Created by kuanwei on 2021/7/2.
//

import SwiftUI
import WidgetKit

struct CharacterNameView: View {
    let character: CharacterDetail

    init(_ character: CharacterDetail?) {
        self.character = character ?? CharacterDetail.panda
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(character.avatar)
                .font(.title)
                .fontWeight(.bold)
                .minimumScaleFactor(0.25)
            Text("Level \(character.level)")
                .minimumScaleFactor(0.5)
            Text("\(character.exp) XP")
                .minimumScaleFactor(0.5)
        }
    }
}

struct CharacterNameView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterNameView(CharacterDetail.panda)
    }
}
