//
//  utils.swift
//  CleanUIKit
//
//  Created by Chris K on 10/19/22.
//

import Foundation

// Mark: Entites

struct Entities {
    struct Folder {
        let id: String
        let name: String
        let files: [File]
    }
    
    struct File {
        let id: String
        let name: String
        let size: Int
    }
}


// MARK DataStore / Service

protocol DataStoreLogic {
    func listAll(completion: (Result<[Entities.Folder], Error>) -> ())
    func create(folder: Entities.Folder, completion:(Result<Bool, Error>) -> ())
    func load(folderId: String, completion:(Result<Entities.Folder, Error>) -> ())
    func delete(folderId: String, completion:(Result<Bool, Error>) -> ())
}

struct DataStore {
    static let samples: [Entities.Folder] = [
        Entities.Folder(id: "1", name: "1", files: [])
    ]
    
    class APIDataStore: DataStoreLogic {
        func listAll(completion: (Result<[Entities.Folder], Error>) -> ()) {
            completion(.success(samples))
        }
        
        func create(folder: Entities.Folder, completion: (Result<Bool, Error>) -> ()) {
        }
        
        func load(folderId: String, completion: (Result<Entities.Folder, Error>) -> ()) {
        }
        
        func delete(folderId: String, completion: (Result<Bool, Error>) -> ()) {
        }
    }
    
    class CacheDataStore: DataStoreLogic {
        func listAll(completion: (Result<[Entities.Folder], Error>) -> ()) {
        }
        
        func create(folder: Entities.Folder, completion: (Result<Bool, Error>) -> ()) {
        }
        
        func load(folderId: String, completion: (Result<Entities.Folder, Error>) -> ()) {
        }
        
        func delete(folderId: String, completion: (Result<Bool, Error>) -> ()) {
        }
    }
}

struct Workers {
    class FileSystemWorker {
        let apiDataStore: DataStoreLogic
        let cacheDataStore: DataStoreLogic
        
        init(apiDataStore: DataStoreLogic, cacheDataStore: DataStoreLogic) {
            self.apiDataStore = apiDataStore
            self.cacheDataStore = cacheDataStore
        }
 
        func listAll(completion: (Result<[Entities.Folder], Error>) -> ()) {
            apiDataStore.listAll(completion: completion)
        }
        func create(folder: Entities.Folder, completion:(Result<Bool, Error>) -> ()) {}
        func load(folderId: String, completion:(Result<Entities.Folder, Error>) -> ()) {}
        func delete(folderId: String, completion:(Result<Bool, Error>) -> ()) {}
    }
}

