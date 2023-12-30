

import SwiftUI
import WatchKit

struct ContentView: View {
    @State var items: [NotesF] = []
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Notes").bold().font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).frame(height:40)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .leading)
            
                var dataTools = DataTools.shared
                List{
                    NavigationLink (destination:AddNewView(order:items.count)){
                        Text("Add New Note")
                            .frame(height:40)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .bold()
                            .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(Color.orange)
                            .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                    }
//                    Button("Refresh"){
//                        refresh.toggle()
//                        dataTools = DataTools.shared
//                        items = dataTools.getitems()
//                        print("refresh")
//                    }
                
                    ForEach(items){
                            item in
                            
                        NavigationLink(destination:EditContent(
                            filename: item.filenameF
                            ,contentrow:item.contentF,star:item.starred)){
                                
                                VStack{
                                    HStack {
                                        
                                        Text(item.filenameF)
                                            .frame(height:20)
                                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment:.leading)
                                            .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                                            .bold()
                                        
                                        Text(item.dateF.formatted())
                                            .font(.system(size: 10))
                                            .frame(height: 10)
                                            .frame(maxWidth: .infinity,alignment:.trailing)
                                            .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                                        
                                        if(item.starred){
                                            Image(systemName: "star.fill").foregroundStyle(Color.orange).imageScale(.small).frame(height: 10).opacity(0.9)
                                        }
                                    }
                        
                                    if(item.contentF != []){
                                        Text(item.contentF[0])
                                            .font(.system(size: 10))
                                            .frame(height: 10)
                                            .frame(maxWidth: .infinity,alignment:.leading)
                                            .bold()
                                            .opacity(0.5)
                                    }
                                    
                                }
                        }.swipeActions(edge: .trailing){
                            Button{
                                dataTools.delete(item2: item)
                                dataTools = DataTools.shared
                                items = dataTools.getitems().reversed()
                                print("Refreshed on ContentView")
                            }label: {
                                Image(systemName: "trash")
                            }.tint(Color.red)
                            
                        }.swipeActions(edge: .leading){
                            Button{
                                dataTools.togglestar(item3: item)
                                dataTools = DataTools.shared
                                items = dataTools.getitems().reversed()
                                print("Refreshed on ContentView")
                            }label: {
                                Image(systemName: "star.fill")
                            }.tint(Color.orange).opacity(0.9)
                        }
                    }
                }.onAppear(){
                    dataTools = DataTools.shared
                    items = dataTools.getitems().reversed()
                    print("Refreshed on ContentView")
                }
            }
                 
        }.frame(alignment: .top)
    }
}

#Preview {
    ContentView()
}
