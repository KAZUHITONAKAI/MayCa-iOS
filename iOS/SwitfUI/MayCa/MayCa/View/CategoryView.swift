struct CategoryView: View {
    @State private var fruits = ["りんご", "オレンジ", "バナナ", "パイナップル", "いちご"]
    
    var body: some View {
        VStack {
            EditButton()
            
            List {
                ForEach(fruits, id: \.self) { fruit in
                    Text(fruit)
                }
                .onDelete(perform: rowRemove)
            }
            .listStyle(PlainListStyle())
        }
    }
    var body: some View {
        NavigationView{
            List {
                ForEach(
                    fruits,
                    id: \.self
                ) { fruit in
                    Text(fruit)
                }
                .onDelete { self.deleteFruit(at :$0) }
                .onMove { self.moveFruit(from: $0, to: $1) }
            }
            .navigationTitle("Fruits")
            .toolbar { EditButton() }
        }
    }

    func rowRemove(offsets: IndexSet) {
        fruits.remove(atOffsets: offsets)
    }
}