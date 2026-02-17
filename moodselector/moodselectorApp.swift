import SwiftUI
import Sentry

@main
struct moodselectorApp: App {
    init(){
        SentrySDK.start{ options in
            options.dsn = "https://4f6c4fb04b9561b3c1cb79013f77ff0f@o4510861395623936.ingest.us.sentry.io/4510872152178688"
            options.tracesSampleRate = 1.0
            options.debug = true
            options.enableUIViewControllerTracing = true
            options.configureUserFeedback = { config in
                config.onSubmitSuccess = {data in print("Feedback sent: \(data)")}
                
            }
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
