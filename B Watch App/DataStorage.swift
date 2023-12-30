//
//  DataStorage.swift
//  B Watch App
//
//  Created by Zac Yang on 2023/9/23.
//

import Foundation
import SwiftData

@Model
final class NotesF:ObservableObject{
    var filenameF : String
    var filedataF : String
    var contentF : [String]
    var dateF : Date
    var starred : Bool
    
    
    init(filenameF: String, filedataF: String, contentF: [String], dateF: Date, starred: Bool) {
        self.filenameF = filenameF
        self.filedataF = filedataF
        self.contentF = contentF
        self.dateF = dateF
        self.starred = starred
    }
}

class DataTools:ObservableObject{
    static var shared = DataTools()
    @Published var container: ModelContainer?
    @Published var context: ModelContext?

    init() {
        do {
            container = try ModelContainer(for: NotesF.self)
            if let container {
                context = ModelContext(container)
            }
        } catch {
            print(error)
        }
    }


    func insert(item : NotesF) {
        context?.insert(item)
        print("Added:"+item.filenameF)
        save()
    }
    
    func togglestar(item3:NotesF){
        let item = NotesF(filenameF: item3.filenameF, filedataF: item3.filedataF, contentF: item3.contentF
                          , dateF: item3.dateF, starred: !item3.starred)
        update(item2: item)
    }
    
    func update(item2: NotesF){
        let list = getitems()
        for item in list{
            if item.filenameF == item2.filenameF{
                context?.delete(item)
                context?.insert(item2)
                
                print("Changed:"+item.filenameF)
                save()
                return
            }
        }
        save()
    }
    
    func delete(item2: NotesF){
        let list = getitems()
        for item in list{
            if item.filenameF == item2.filenameF{
                context?.delete(item)
                print("Deleted:"+item.filenameF)
                save()
                return
            }
        }
        save()
    }
    
    func find(finder: NotesF) -> Bool{
        let list = getitems()
        if list.isEmpty {
            return false
        }
        for item in list{
            if item.filenameF == finder.filenameF{
                return true
            }
        }
        return false
    }
    
    func getitems() -> [NotesF]{
        let descriptor = FetchDescriptor<NotesF>(sortBy: [SortDescriptor<NotesF>(\.dateF)])
        do {
            guard let data = try context?.fetch(descriptor) else { return [] }
            
            return data
        } catch {
            print(error)
        }
        return []
    }
    
    func DeveloperUse_Print(){
        var i = 0
        for item in getitems(){
            i += 1
            print("---------------[",i,"]----------------")
            print("Name:",item.filenameF)
            print("Date",item.dateF)
            print("Content",item.contentF)
            print("Starred",item.starred)
        }
    }
    func save() {
        do {
            try context?.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}


