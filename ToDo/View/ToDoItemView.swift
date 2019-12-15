import SwiftUI

struct ToDoItemView: View {
    let toDoItem: ToDoItem
    
    var body: some View {
        Button(action: {
            self.toDoItem.isDone = NSNumber(booleanLiteral: true)
            }
        ) {
            HStack {
                VStack(alignment: .leading) {
                    Text(toDoItem.title ?? "Your item")
                        .font(.headline)
                    Text(toDoItem.createdAt != nil ? "\(toDoItem.createdAt!)" : "Date")
                        .font(.caption)
                }
            }
        }
    }
}

struct ToDoItemView_Previews: PreviewProvider {
    
    static var previews: some View {
        ToDoItemView(toDoItem: ToDoItem())
    }
}
