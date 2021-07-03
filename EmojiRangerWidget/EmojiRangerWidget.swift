//
//  EmojiRangerWidget.swift
//  EmojiRangerWidget
//
//  Created by kuanwei on 2021/7/3.
//

import WidgetKit
import SwiftUI

struct Provider: IntentTimelineProvider {

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), character: .panda, relevance: nil)
    }

    func getSnapshot(for configuration: CharacterSelectionIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), character: .panda, relevance: nil)
        completion(entry)
    }

    func getTimeline(for configuration: CharacterSelectionIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {

        let selectedCharacter = character(for: configuration)
        let endDate = selectedCharacter.fullHealthDate
        let oneMinute: TimeInterval = 60
        var currentDate = Date()

        var entries: [SimpleEntry] = []
        while currentDate < endDate {
            let relevance = TimelineEntryRelevance(score: Float(selectedCharacter.healthLevel))
            let entry = SimpleEntry(date: currentDate, character: selectedCharacter, relevance: relevance)
            currentDate += oneMinute
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

    private func character(for configuration: CharacterSelectionIntent) -> CharacterDetail {
        switch configuration.hero {
        case .panda:
            return .panda
        case .egghead:
            return .egghead
        case .spouty:
            return .spouty
        default:
            return .panda
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let character: CharacterDetail
    let relevance: TimelineEntryRelevance?
}

struct EmojiRangerWidgetEntryView : View {
    var entry: Provider.Entry

    @Environment(\.widgetFamily) var family

    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            ZStack {
                AvatarView(entry.character)
                    .foregroundColor(.white)
            }
            .background(Color.gameBackground)
            .widgetURL(entry.character.url)
        default:
            ZStack {
                HStack(alignment: .top) {
                    AvatarView(entry.character)
                        .foregroundColor(.white)
                    Text(entry.character.bio)
                        .padding()
                        .foregroundColor(.white)
                }
                .padding()
                .widgetURL(entry.character.url)
            }
            .background(Color.gameBackground)
        }
    }
}

struct PlaceHolderView: View {
    var body: some View {
        EmojiRangerWidgetEntryView(entry: SimpleEntry(date: Date(), character: .panda, relevance: nil))
    }
}

struct EmojiRangerWidget: Widget {
    let kind: String = "EmojiRangerWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: CharacterSelectionIntent.self, provider: Provider()) { entry in
            EmojiRangerWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Emoji Ranger Detail")
        .description("Keep track of your favoite emoji ranger.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct EmojiRangerWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EmojiRangerWidgetEntryView(entry: SimpleEntry(date: Date(), character: .panda, relevance: nil))
                .previewContext(WidgetPreviewContext(family: .systemSmall))

            EmojiRangerWidgetEntryView(entry: SimpleEntry(date: Date(), character: .panda, relevance: nil))
                .previewContext(WidgetPreviewContext(family: .systemMedium))

            PlaceHolderView()
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .redacted(reason: .placeholder)
        }
    }
}
