import SwiftUI
import Sentry
struct FeedbackView : View{
    @State private var name = ""
    @State private var email = ""
    @State private var comments = ""
    @State private var showAlert = false
    @Environment(\.dismiss) var dismiss
    var body : some View{
        NavigationStack{
            Form{
                Section(header:Text("Info")){
                    TextField("Name", text:$name)
                        .foregroundStyle(.black)
                    TextField("Email", text:$email)
                        .keyboardType(.emailAddress)
                        .foregroundStyle(.black)
                }
                Section(header:Text("Comments")){
                    TextEditor(text:$comments)
                        .frame(minHeight: 100)
                        .foregroundStyle(.black)
                }
            }
            .navigationTitle("Send Feedback")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel"){dismiss()}
                        .foregroundStyle(.black)
                    
                }
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Sent"){
                        sendUserFeedback(name: name, email: email, comments: comments)
                        showAlert.toggle()
                    }
                    
                    .foregroundStyle(.black)
                    .disabled(comments.isEmpty)
                    
                }
            }
            
            .alert("Thanks for you Feedback",isPresented: $showAlert){
                Button("OK"){dismiss()}
                    .foregroundStyle(.black)
            }message: {
                Text("You message sent")
            }
            
        }
    }
    func sendUserFeedback(name: String, email: String, comments: String){
        SentrySDK.capture(message: "User Feedback \(comments)"){
            scope in
            scope.setUser(User(userId: name))
            scope.setExtra(value: "name", key: name)
            scope.setExtra(value: "comments", key: comments)
            scope.setExtra(value: "email", key: email)
            scope.setTag(value: "user_feedback", key: "type")
        }
    }
}
