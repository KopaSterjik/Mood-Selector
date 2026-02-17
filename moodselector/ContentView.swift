import SwiftUI

//list itam params
struct ListItem:Identifiable,Hashable{
    var id = UUID()
    var emoji: String
    var text: String
    var date : Date
}


//View how list item looks like
struct ListItemView: View{
    let item : ListItem
    var body :some View{
        HStack(
            alignment:.center ,spacing: 50){
                HStack{
                    Text(item.emoji)
                        .font(.system(size: 40))
                }
                VStack(
                    alignment: .leading, spacing:10){
                        Text(item.text)
                            .font(.title2.bold())
                        Text("\(item.date.formatted(.dateTime.day().month(.abbreviated))), \(item.date.formatted(date: .omitted, time: .shortened))")
                    }
            }
    }
}


struct ContentView: View {
    @State private var listItems:[ListItem] = []
    @State private var showView = false
    @State private var selectedView = 0
    var body: some View {
        TabView(selection: $selectedView){
            Tab("General", systemImage: "person",value: 0){
                NavigationStack{
                    List{
                        ForEach(listItems){item in
                            ListItemView(item: item)
                        }
                    }
                    .navigationTitle("My Moods")
                    .navigationBarTitleDisplayMode(.inline)
                    
                    .sheet(isPresented: $showView){
                        AddItemView(list: $listItems)
                    }
                    .toolbar{
                        Button(action:{ showView.toggle()}){
                           Image(systemName: "plus")
                        }
                        
              
                    }
                }
                .overlay{
                    if listItems.isEmpty {
                        ContentUnavailableView("No moods today", systemImage:"note.text" , description: Text("Tap + to record how you're feeling right now"))
                    }
                }
            }
            
            Tab("Debug", systemImage: "ladybug",value:1) {
                DebugView(value: $selectedView)
            }
        }
        
    }
       

}
   



#Preview {
    ContentView()
    
}

