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
                        emoji: "🫥 \(Date.now.timestamp)"
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

final class DataAvailableHelper: ObservableObject {
    
    @Published private(set) var onDataAvailable: String = ""
    
    public init() {
        NotificationCenter.default.addObserver(self, selector: #selector(dataDidBecomeAvailable), name: UIApplication.protectedDataDidBecomeAvailableNotification, object: nil)
        if UIApplication.shared.isProtectedDataAvailable {
            onDataAvailable = Date.now.timestamp
        }
    }
    
    @objc func dataDidBecomeAvailable(notification: Notification) {
        onDataAvailable = Date.now.timestamp
    }
}

struct ContentView: View {
    
    @StateObject private var activityHelper = ActivityHelper()
    @StateObject private var dataAvailableHelper = DataAvailableHelper()
    
    @State var finishedOnboarding: Bool = UserDefaults.standard.bool(forKey: "onboarding") {
        didSet {
            UserDefaults.standard.set(finishedOnboarding, forKey: "onboarding")
        }
    }
    
    @State var onAppearTimestamp: String = ""
    
    let initAt: String
    init() {
        initAt = Date.now.timestamp
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
                VStack(spacing: 20) {
                    VStack(spacing: 10) {
                        Text("View init at \(initAt)")
                            .monospaced()
                        Text("App did finish launching at \(AppDelegate.didFinishLaunchingWithOptionsCalledAt)")
                            .monospaced()
                        Text("Data became available at \(dataAvailableHelper.onDataAvailable)")
                            .monospaced()
                        Text("View did appear \(onAppearTimestamp)")
                            .monospaced()
                    }
                    .font(.system(size: 12, weight: .regular, design: .monospaced))
                    
                    Text("Finish onboarding?")
                    Button {
                        finishedOnboarding = true
                    } label: {
                        Text("I finished the onboarding")
                    }
                    
                }
            }
        }.onAppear {
            onAppearTimestamp = Date.now.timestamp
        }
    }
}

#Preview {
    ContentView()
}
