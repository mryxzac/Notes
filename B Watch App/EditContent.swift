//
//  EditContent.swift
//  B Watch App
//
//  Created by Zac Yang on 2023/9/23.
//

import SwiftUI
struct EditContent: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var rowvalue : String = ""//input method
    var filename : String
    @State var contentrow : [String] = []
    @State var star:Bool = false
    var dataTools = DataTools.shared
    var notesss = [NotesF]()
    
    var body: some View {
    NavigationStack(root: {
    ScrollViewReader { proxy in
    ScrollView {
        VStack(spacing: 0) {
            Spacer()
            HStack {
                Text(filename)
                    .bold()
                    .frame(maxWidth:.infinity,alignment: .leading)
                .font(.title2)
                if(star){
                    Image(systemName: "star.fill").foregroundStyle(Color.orange).padding().opacity(0.9)
                        .onTapGesture {
                            star.toggle()
                        }
                }else{
                    Image(systemName: "star").foregroundStyle(Color.orange).padding().opacity(0.9)
                        .onTapGesture {
                            star.toggle()
                        }
                    
                }
            }
            
            Spacer()
                .frame(height: 10)
            
            HStack {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).frame(width: 10)
                    .foregroundStyle(Color.orange)
                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                Spacer()
                VStack {
                    ForEach(contentrow.indices,id:\.self) { row in
                        ZStack {
                            Text(self.contentrow[row])
                                .frame(
                                maxWidth:.infinity,alignment: .leading)
                                
                            Image(systemName: "minus.circle")
                                .frame(
                                maxWidth:.infinity,alignment: .trailing)
                                .foregroundStyle(Color.red)
                                .onTapGesture {
                                    contentrow.remove(at: row)
                                }
                        }
                    }
                }
            }
        }
        Spacer()
            .frame(height: 10)
        Divider()
        Spacer()
            .frame(height: 10)
        TextField("New Row", text: $rowvalue)
            .onSubmit {
                contentrow.append(rowvalue)
                rowvalue=""
            }
        Spacer()
            .frame(height: 10)
        
        let date = Date()
        let note1 = NotesF(filenameF: filename, filedataF: " ", contentF: contentrow , dateF: date ,starred: star)
        Button("Save"){
            if dataTools.find(finder: note1){
                dataTools.update(item2: note1)
            }else{
                dataTools.insert(item: note1)
            }
            dataTools.DeveloperUse_Print()
            self.presentationMode.wrappedValue.dismiss()
        }.foregroundStyle(Color.orange)
            .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            
        if(dataTools.find(finder: note1)){
            Button("Delete"){
                dataTools.delete(item2: note1)
                self.presentationMode.wrappedValue.dismiss()

            }.foregroundStyle(Color.red)
                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
        }
    }
        //Scroll View
    }
    })
}
}

extension String {
    
    /// 截取字符串
    /// - Parameters:
    ///   - begin: 开始截取的索引
    ///   - count: 需要截取的个数
    /// - Returns: 字符串
    func substring(start: Int, _ count: Int) -> String {
        if(self.count <= count){
            return self
        }
        let begin = index(startIndex, offsetBy: max(0, start))
        let end = index(startIndex, offsetBy: min(count, start + count))
        return String(self[begin..<end])
    }
    
}


#Preview {
    EditContent(filename: "Empty")
}
