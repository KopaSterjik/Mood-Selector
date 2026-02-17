import SwiftUI
import Sentry

struct MyModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .font(.system(size: 20))
            .frame(maxWidth: .infinity)
            .buttonStyle(.borderedProminent)
            .foregroundStyle(.white)
            .clipShape(Ellipse())
    }
}



struct DebugView : View{
    @Binding var value : Int
    @State private var showFeedback = false
    var body:some View{
        NavigationStack{
            Form{
                Section(header:Text("Sentry Testing")){
                    Text("Use the button below to trigger a test crash. This will send a crash report to Sentry to verify your integration.")
                    Button("Test Crash"){
                        SentrySDK.crash()
                    }
                    .modifier(MyModifier())
                    .tint(Color.red)
                      Button("Test Error"){
                          showFeedback.toggle()
                    }
                      .sheet(isPresented: $showFeedback){
                          FeedbackView()
                      }
                    .modifier(MyModifier())
                    .tint(Color.yellow)
                    
                    
                }
                .listRowSeparator(.hidden)
                Section(header: Text("Info")){
                    Text("Sentry DSN: ")
                    Text("App Version: 1.0")
                    Text("Build: 1")
                }
            }
            .navigationTitle("Debug")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Button(action: {value = 0}){
                        HStack(spacing: 15){
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        
                    }
                }
            }
        }
    }
    
    
}
