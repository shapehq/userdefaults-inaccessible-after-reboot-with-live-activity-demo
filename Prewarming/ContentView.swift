//
//  ContentView.swift
//  Prewarming
//
//  Created by Jonatan Nielavitzky on 09/09/2024.
//

import SwiftUI
import ActivityKit
import PrewarmingExtExtension

final class ActivityHelper: ObservableObject {
    @MainActor @Published private(set) var activityID: String?
    
    func start() {
        Task {
            if ActivityAuthorizationInfo().areActivitiesEnabled {
                do {
                    let adventure = PrewarmingExtAttributes(name: "hero")
                    let initialState = PrewarmingExtAttributes.ContentState(
                        emoji: "🫥"
                    )
                    
                    let activity = try Activity.request(
                        attributes: adventure,
                        content: .init(state: initialState, staleDate: nil)
                    )
                    
                    await MainActor.run { activityID = activity.id }
                } catch(let error) {
                    print("Error \(error)")
                }
            }
        }
    }
}

struct ContentView: View {
    
    @StateObject private var activityHelper = ActivityHelper()
    
    @State var finishedOnboarding: Bool = UserDefaults.standard.bool(forKey: "onboarding") {
        didSet {
            UserDefaults.standard.set(finishedOnboarding, forKey: "onboarding")
        }
    }
    
    var body: some View {
        Group {
            if finishedOnboarding {
                VStack {
                    Button(action: {
                        activityHelper.start()
                    }, label: {
                        Text("Start live activity")
                    }).padding()
                }
                .padding()
            } else {
                VStack {
                    Text("Finish onboarding?")
                    Button {
                        finishedOnboarding = true
                    } label: {
                        Text("I finished the onboarding")
                    }
                    
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
