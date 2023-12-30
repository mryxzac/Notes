//
//  AddNewView.swift
//  B Watch App
//
//  Created by Zac Yang on 2023/9/22.
//

import SwiftUI

struct AddNewView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var backd:Bool = false
    @State private var filename: String = ""
    var order: Int
    var body: some View {
        NavigationView(content: {
            VStack{
                Text("Name Your Note").bold()
                
                TextField("NewNote", text:$filename)
                
                NavigationLink(destination:EditContent(filename: filename)){
                    Text("Confirm").bold()
                }
                .onAppear(){
                    filename = "NewFile_"+String(order+1)
                    print("Creating new file"+filename)
                }
                .onDisappear(){
                    backd.toggle()
                    filename = filename.substring(start: 0, 15)
                    print("Back toggled")
                }
                .foregroundStyle(Color.orange)
                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            }.onAppear(){
                if(backd){
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
        )
       
    }
}

#Preview {
    AddNewView(order:0)
}
