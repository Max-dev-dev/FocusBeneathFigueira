import SwiftUI

enum Tab {
    case task, articles, timer, game, settings
}

struct MainView: View {
    @State private var selectedTab: Tab = .task
    @State var loading = true
    
    var body: some View {
        if loading {
            LoaderView(close: {loading = false})
        } else {
            NavigationView {
                VStack {
                    Group {
                        switch selectedTab {
                        case .task:
                            TaskView()
                        case .articles:
                            ArticlesView()
                        case .timer:
                            TimerView()
                        case .game:
                            GameStartView()
                        case .settings:
                            SettingsView()
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    CustomTabBar(selectedTab: $selectedTab)
                }
                .background {
                    Image(.backBlackScreen)
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()
                }
            }
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab

    var body: some View {
        HStack {
            TabButton(tab: .task, selectedTab: $selectedTab, activeIcon: .taskIconactive, inactiveIcon: .taskIconinactive)
            TabButton(tab: .articles, selectedTab: $selectedTab, activeIcon: .articlesIconactive, inactiveIcon: .articlesIconinactive)
            TabButton(tab: .timer, selectedTab: $selectedTab, activeIcon: .timerIconactive, inactiveIcon: .timerIconinactive)
            TabButton(tab: .game, selectedTab: $selectedTab, activeIcon: .gameIconactive, inactiveIcon: .gameIconinactive)
            TabButton(tab: .settings, selectedTab: $selectedTab, activeIcon: .settingsIconactive, inactiveIcon: .settingsIconinactive)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
        .background(Color.black.opacity(0.9))
    }
}

struct TabButton: View {
    let tab: Tab
    @Binding var selectedTab: Tab
    let activeIcon: ImageResource
    let inactiveIcon: ImageResource

    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            Image(selectedTab == tab ? activeIcon : inactiveIcon)
        }
        .frame(maxWidth: .infinity)
    }
}


#Preview {
    MainView()
}
