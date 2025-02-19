import SwiftUI
import WebKit
import OneSignalFramework

struct Fsadadsda: View {
    
    let formedUrl: String
    let stamp: String
    let base: String
    let shouldSendPush: Bool
    @State private var shouldNavigateRootView = false
    @State private var newUrl: URLRequest?
    @State private var showingAlertRootView  = false
    
    @State private var shouldGoBack = false
    @State private var shouldReload = false
    @State private var isLoading = true

     var parentScreenWebView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        return WKWebView(frame: .zero, configuration: configuration)
    }()


    @State private var angle: Double = 0.0
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    GeometryReader { geometry in
                    WKWebViewRepresentable(url: URL(string: formedUrl)!, webView: parentScreenWebView, shouldNavigateRootWebView:
                                            $shouldNavigateRootView, newUrl: $newUrl, showingAlertRootWebView: $showingAlertRootView, stamp: stamp, base: base, shouldSendPush: shouldSendPush, shouldGoBack: $shouldGoBack, shouldReload: $shouldReload, isLoading: $isLoading)
                            .edgesIgnoringSafeArea(.bottom).frame(width: geometry.size.width, height: geometry.size.height)
                        
                    }
                    if (isLoading) {
                        ZStack {
                                    Color.black
                                        .ignoresSafeArea()
                                    
                                    Circle()
                                        .trim(from: 0.1, to: 1.0)
                                        .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                                        .foregroundStyle(Color.white)
                                        .frame(width: 50, height: 50)
                                        .rotationEffect(Angle(degrees: angle))
                                        .onAppear {
                                            withAnimation(Animation.linear(duration: 4.0).repeatForever(autoreverses: false)) {
                                                angle = 360
                                            }
                                        }
                                }
                    }
                    
                }
                
                HStack {
                    Button(action: {
                        shouldGoBack = true // Сообщаем WebView вернуться назад
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            shouldGoBack = false // Сбрасываем состояние
                                        }
                    }) {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        shouldReload = true // Сообщаем WebView вернуться назад
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            shouldReload = false // Сбрасываем состояние
                                        }

                    }) {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.white)
                            .padding()
                    }
                }.ignoresSafeArea(edges: .bottom)
                
            }.preferredColorScheme(.dark).ignoresSafeArea(edges: .bottom)
        }.navigationBarHidden(true).alert("There is no such app on your device. Choose another option.", isPresented: $showingAlertRootView) {
            Button("OK", role: .cancel) { }
        }.navigationViewStyle(.stack).ignoresSafeArea(edges: .bottom)
        
    }
}

struct WKWebViewRepresentable: UIViewRepresentable {
    
    typealias UIViewType = WKWebView
    var url: URL
    var webView: WKWebView
    
    @Binding var shouldNavigateRootWebView: Bool
    @Binding var newUrl: URLRequest?
    @Binding var showingAlertRootWebView: Bool
    
    let stamp: String
    let base: String
    let shouldSendPush: Bool
    
    @Binding var shouldGoBack: Bool
    @Binding var shouldReload: Bool
    @Binding var isLoading: Bool
    
    func sendEvent(eventName: String, timestamp: String, url: String) {
        guard let new2rl = URL(string: "\(url)?dasfsa=\(eventName)&fasfasda=\(timestamp)") else {
                return
            }
            var request = URLRequest(url: new2rl)
            request.httpMethod = "GET"
  
            let task = URLSession.shared.dataTask(with: request) { _, _, _ in
            }
                        task.resume()
    }
    
    func makeUIView(context: Context) -> WKWebView {
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
        webView.configuration.allowsInlineMediaPlayback = true
        webView.allowsBackForwardNavigationGestures = true
        webView.configuration.mediaTypesRequiringUserActionForPlayback = []
        webView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 17_2_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.2 Mobile/15E148 Safari/604.1"
        webView.configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
       
        let request = URLRequest(url: url)
        
        webView.load(request)
        
        sendEvent(eventName: "webview_open", timestamp: stamp, url: base)
        OneSignal.Notifications.requestPermission({ accepted in
            if (accepted == true) {
                if (shouldSendPush) {
                    self.sendEvent(eventName: "push_subscribe", timestamp: stamp, url: base)
                }
            }
        }, fallbackToSettings: false)
        return webView
    }
    
    func isNotFirstOpen() -> Bool {
        return UserDefaults.standard.bool(forKey: "FIRST_OPEN")
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if shouldReload {
            context.coordinator.reload()
        }
        if shouldGoBack {
            context.coordinator.goBack()
        }
    }
}


extension WKWebViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
        var parent: WKWebViewRepresentable
        var webViews: [WKWebView]
        
        init(_ parent: WKWebViewRepresentable) {
            self.parent = parent
            self.webViews = []
        }

        
        func goBack()
        {
            if(webViews.isEmpty) {
                parent.webView.goBack()
            } else {
                webViews.last?.removeFromSuperview()
                webViews.removeLast()
            }
        }
        
        func reload() {
            if webViews.isEmpty {
                parent.webView.reload()
            } else {
                webViews.last?.reload()
            }
        }
        
        func webViewDidClose(_ webView: WKWebView) {
                webView.removeFromSuperview()
                webViews.removeAll()
            }
    
        
        
        @available(iOS 15.0, *)
        func webView(
            _ webView: WKWebView,
            requestMediaCapturePermissionFor
            origin: WKSecurityOrigin, initiatedByFrame
            frame: WKFrameInfo,
            type: WKMediaCaptureType,
            decisionHandler: @escaping (WKPermissionDecision) -> Void) {
                decisionHandler(.grant)
            }
        
        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            if navigationAction.targetFrame == nil {
                let popupWebView = WKWebView(frame: .zero, configuration: configuration)
                popupWebView.navigationDelegate = self
                popupWebView.uiDelegate = self
                popupWebView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 17_2_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.2 Mobile/15E148 Safari/604.1"
                
                parent.webView.addSubview(popupWebView)
                popupWebView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    popupWebView.topAnchor.constraint(equalTo: parent.webView.topAnchor),
                    popupWebView.bottomAnchor.constraint(equalTo: parent.webView.bottomAnchor),
                    popupWebView.leadingAnchor.constraint(equalTo: parent.webView.leadingAnchor),
                    popupWebView.trailingAnchor.constraint(equalTo: parent.webView.trailingAnchor)
                ])
                
                self.webViews.append(popupWebView)
                return popupWebView
            }
            
            return nil
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            if(parent.isLoading) {
                if let finalURL = webView.url {
                    if (finalURL.absoluteString.contains(parent.base)) {
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.parent.isLoading = false
                        }
                    }
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        self.parent.isLoading = false
                    }
                }
            }
            

        }

        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            
            if let url = navigationAction.request.url {
                let schemes = getCustomSchemesFromPlist()
                if schemes.contains(url.scheme ?? "value") {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        parent.showingAlertRootWebView = true
                    }
                    decisionHandler(.cancel)
                    return
                }
            }

            if parent.url.absoluteString == navigationAction.request.url?.absoluteString {
                let cookieStore = webView.configuration.websiteDataStore.httpCookieStore
                cookieStore.getAllCookies { cookies in
                    let isCookiesEmpty = cookies.isEmpty
                    let newUrlString = self.parent.url.absoluteString + "&isCookiesEmpty=\(isCookiesEmpty)"
                    
                    if let newUrl = URL(string: newUrlString) {
                        let newRequest = URLRequest(url: newUrl)
                        DispatchQueue.main.async {
                            webView.load(newRequest)
                        }
                    }
                }
                decisionHandler(.cancel) // Вызов обработчика сразу
                return
            }

            decisionHandler(.allow)
        }

        
        private func getCustomSchemesFromPlist() -> [String] {
                    if let urlSchemes = Bundle.main.object(forInfoDictionaryKey: "LSApplicationQueriesSchemes") as? [String] {
                        return urlSchemes.map { $0.lowercased() }
                    }
                    return []
                }
    }
}
