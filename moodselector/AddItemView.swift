import SwiftUI
import Sentry
struct AddItemView: View{
    @Binding var list: [ListItem]
    @Environment(\.dismiss) var dismiss
    @State private var text = ""
    @State var selected: String = "😀"
    @State private var selectorMood :[String] = ["😃","😊","😑","🥲","😡"]
    
    var body: some View{
        
        NavigationStack{
            Form{
                Section(header:Text("How are you feeling today?")){
                    HStack(spacing: 12) {
                        ForEach(selectorMood, id: \.self) { emoji in
                            Text(emoji)
                                .font(.system(size: 36))
                                .padding(8)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(selected == emoji ? Color.blue.opacity(0.15) : Color.clear)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(selected == emoji ? Color.blue : Color.clear, lineWidth: 2.5)
                                )
                                .onTapGesture {
                                    selected = emoji
                                }
                        }
                    }
                    
                }
                
                Section(header:Text("Note(Optional)")){
                    TextField("What's on your mind?", text: $text)
                    
                }
                
                
                Section{
                    Button("Save"){
                        addItem()
                    }
                    
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 20))
                    .buttonBorderShape(.capsule)
                    .foregroundStyle(.white)
                    .buttonStyle(.borderedProminent)
                    .tint(Color.green)
                    
                }
                .listRowBackground(Color.clear)
                //Stack Styles
                .toolbar{
                    Button(role: .cancel){
                        dismiss()
                    }
                }
                
                .navigationTitle("Add Mood")
                .navigationBarTitleDisplayMode(.inline)
            }
            .formStyle(.grouped)
            
            
            
        }
    }
    
    func addItem(){
        let crumb = Breadcrumb(level: .info, category: "mood")
        crumb.message = "User add item to list \(selected)"
        crumb.data = [
            "emoji" : selected,
            "hasNote" : !text.isEmpty
        ]
        SentrySDK.addBreadcrumb(crumb)
        list.append(ListItem(emoji: selected, text: text, date: Date()))
        dismiss()
    }
    
}
