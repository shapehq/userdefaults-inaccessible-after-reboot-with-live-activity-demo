//
//  PrewarmingExtLiveActivity.swift
//  PrewarmingExt
//
//  Created by Jonatan Nielavitzky on 09/09/2024.
//

import ActivityKit
import WidgetKit
import SwiftUI


struct PrewarmingExtLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: PrewarmingExtAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension PrewarmingExtAttributes {
    fileprivate static var preview: PrewarmingExtAttributes {
        PrewarmingExtAttributes(name: "World")
    }
}

extension PrewarmingExtAttributes.ContentState {
    fileprivate static var smiley: PrewarmingExtAttributes.ContentState {
        PrewarmingExtAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: PrewarmingExtAttributes.ContentState {
         PrewarmingExtAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: PrewarmingExtAttributes.preview) {
   PrewarmingExtLiveActivity()
} contentStates: {
    PrewarmingExtAttributes.ContentState.smiley
    PrewarmingExtAttributes.ContentState.starEyes
}
