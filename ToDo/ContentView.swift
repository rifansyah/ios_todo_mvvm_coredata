import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: ToDoViewModel.getAllToDoItems()) var toDoItems: FetchedResults<ToDoItem>
    
    @State private var newToDoItem = ""
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("What's next ?")) {
                    HStack {
                        TextField("New ToDo", text: self.$newToDoItem)
                        Button(action: {
                            let toDoItem = ToDoItem(context: self.managedObjectContext)
                            toDoItem.title = self.newToDoItem
                            toDoItem.createdAt = Date()
                            toDoItem.isDone = NSNumber(booleanLiteral: false)
                            
                            do {
                                try self.managedObjectContext.save()
                            } catch {
                                print(error)
                            }
                            
                            self.newToDoItem = ""
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                                .imageScale(.large )
                        }
                    }
                }
                .font(.headline)
                
                Section(header: Text("Your todo list")) {
                    ForEach(self.toDoItems) { toDoItem in
                        if toDoItem.isDone == NSNumber(booleanLiteral: false) {
                            ToDoItemView(toDoItem: toDoItem)
                        }
                    }
                    .onDelete { indexSet in
                        let deletedItem = self.toDoItems[indexSet.first!]
                        self.managedObjectContext.delete(deletedItem)
                        
                        do {
                            try self.managedObjectContext.save()
                        } catch {
                            print(error)
                        }
                    }
                }
                
                Section(header: Text("Done")) {
                    ForEach(self.toDoItems) { toDoItem in
                        if toDoItem.isDone == NSNumber(booleanLiteral: true) {
                            ToDoItemView(toDoItem: toDoItem)
                        }
                    }
                    .onDelete { indexSet in
                        let deletedItem = self.toDoItems[indexSet.first!]
                        self.managedObjectContext.delete(deletedItem)
                        
                        do {
                            try self.managedObjectContext.save()
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("ToDo List"))
            .navigationBarItems(trailing: EditButton())
        }
    }
}
  struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
