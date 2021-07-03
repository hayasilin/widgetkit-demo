//
//  IntentHandler.swift
//  EmojiRangerIntentHandler
//
//  Created by kuanwei on 2021/7/3.
//

import Intents

class IntentHandler: INExtension, DynamicCharacterSelectionIntentHandling {

    func provideHeroOptionsCollection(for intent: DynamicCharacterSelectionIntent, with completion: @escaping (INObjectCollection<Hero>?, Error?) -> Void) {

        let characters: [Hero] = CharacterDetail.availableCharacters.map { character in
            let hero = Hero(identifier: character.name, display: character.name)
            return hero
        }

        let remoteCharacter: [Hero] = CharacterDetail.remoteCharacters.map { character in
            let hero = Hero(identifier: character.name, display: character.name)
            return hero
        }

        let collection = INObjectCollection(items: characters + remoteCharacter)

        completion(collection, nil)
    }

    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
}
