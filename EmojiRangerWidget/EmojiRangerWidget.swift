//
//  EmojiRangerWidget.swift
//  EmojiRangerWidget
//
//  Created by kuanwei on 2021/7/3.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), character: .panda)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), character: .panda)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entries: [SimpleEntry] = [SimpleEntry(date: Date(), character: .panda)]

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate)
//            entries.append(entry)
//        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let character: CharacterDetail
}

struct EmojiRangerWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        AvatarView(entry.character)
    }
}

struct PlaceHolderView: View {
    var body: some View {
        AvatarView(.panda)
    }
}

@main
struct EmojiRangerWidget: Widget {
    let kind: String = "EmojiRangerWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            EmojiRangerWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Emoji Ranger Detail")
        .description("Keep track of your favoite emoji ranger.")
        .supportedFamilies([.systemSmall])
    }
}

struct EmojiRangerWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AvatarView(.panda)
                .previewContext(WidgetPreviewContext(family: .systemSmall))

            PlaceHolderView()
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .redacted(reason: .placeholder)
        }
    }
}
