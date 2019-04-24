//
//  CacheService.swift
//  RickAndMortyCatalog
//
//  Created by Eduardo Sanches Bocato on 24/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

/// Defines the CacheService errors
///
/// - encryptionFailed: the key encription has failed
/// - couldNotSaveData: the data could not be saved
/// - couldNotLoadData: the data could not be loaded
/// - raw: some system error, not previously defined
public enum CacheServiceError: Error {
    case encryptionFailed
    case couldNotSaveData
    case couldNotLoadData
    case raw(Error)
}

/// Defines a cache service
public protocol CacheServiceProtocol {
    
    /// Initializes a cache service
    ///
    /// - Parameter fileManager: the file manager for the service, for checking file or directory exists in a specified path
    ///   - documentDirectoryPath: the path of the document directory
    init(fileManager: FileManager, cacheDirectoryName: String)
    
    /// Saves some data in a key
    ///
    /// - Parameters:
    ///   - data: the data to be saved
    ///   - key: the key to save/retrieve the data
    ///   - completion: completion block, with a result
    /// - Returns: void if successfull, an error otherwise
    func save(data: Data, key: String, completion: ((_ result: Result<Void, CacheServiceError>) -> Void)?)
    
    /// Loads the data from the cache (disk or memory)
    ///
    /// - Parameters:
    ///   - key: the key to fetch the data
    ///   - completion: completion block to get its result
    func loadData(from key: String, completion: ((_ result: Result<Data, CacheServiceError>) -> Void))

    /// Clears da cache
    ///
    /// - Parameter completion: returns if the cache could be cleared
    func clear(completion: ((_ result: Result<Data, CacheServiceError>) -> Void)?)
    
}

/// Save and load data to memory and disk cache
public final class CacheService: CacheServiceProtocol {
    
    /// For get or load data in memory
    private let memory = NSCache<NSString, NSData>()
    
    /// The path url that contain cached files (mp3 files and image files)
    private let diskPath: URL
    
    /// For checking file or directory exists in a specified path
    private let fileManager: FileManager
    
    /// Make sure all operation are executed serially
    private let serialQueue = DispatchQueue(label: "CacheService")
    
    // MARK: - Initialization
    
    /// Initializes a cache service
    ///
    /// - Parameter fileManager: the file manager for the service, for checking file or directory exists in a specified path
    ///   - cacheDirectoryName: the path of the cache directory
    public init(fileManager: FileManager = FileManager.default, cacheDirectoryName: String) {
        self.fileManager = fileManager
        do {
            let cachesDirectory = try fileManager.url(
                for: .cachesDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            diskPath = cachesDirectory.appendingPathComponent(cacheDirectoryName)
            try createDirectoryIfNeeded()
        } catch {
            fatalError()
        }
    }
    
    // MARK: - Public functions
    
    public func save(data: Data, key: String, completion: ((_ result: Result<Void, CacheServiceError>) -> Void)? = nil) {
        
        guard let encriptedKey = key.md5 else {
            completion?(.failure(.encryptionFailed))
            return
        }
        
        serialQueue.async {
            self.memory.setObject(data as NSData, forKey: encriptedKey as NSString)
            do {
                try data.write(to: self.filePath(key: encriptedKey))
                completion?(.success(()))
            } catch {
                completion?(.failure(.couldNotSaveData))
            }
        }
        
    }

    public func loadData(from key: String, completion: ((Result<Data, CacheServiceError>) -> Void)) {
        
        guard let encriptedKey = key.md5 else {
            completion(.failure(.encryptionFailed))
            return
        }
        
        if let dataFromMemory = memory.object(forKey: encriptedKey as NSString) {
            completion(.success(dataFromMemory as Data))
        } else if let dataFromDisk = getDataFromDisk(for: encriptedKey) {
            completion(.success(dataFromDisk as Data))
        } else {
            completion(.failure(.couldNotLoadData))
        }
        
    }
    
    public func clear(completion: ((_ result: Result<Data, CacheServiceError>) -> Void)? = nil) {
        
        serialQueue.async {
            
            self.memory.removeAllObjects()
            
            do {
                
                let files = try self.fileManager.contentsOfDirectory(at: self.diskPath, includingPropertiesForKeys: nil, options: [])
                
                try files.forEach {
                    try self.fileManager.removeItem(at: $0)
                }
                
            } catch {
                completion?(.failure(.raw(error)))
            }
            
        }
        
    }
    
    // MARK: - Private Functions
    
    private func filePath(key: String) -> URL {
        return diskPath.appendingPathComponent(key)
    }
    
    private func createDirectoryIfNeeded() throws {
        
        // Get document directory for device, this should succeed
        if fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first != nil {
            
            // If folder URL does not exist, create it
            if !fileManager.fileExists(atPath: diskPath.path) {
                try fileManager.createDirectory(atPath: diskPath.path,
                                                withIntermediateDirectories: true,
                                                attributes: nil)
            }
            
        }
        
    }
    
    private func getDataFromDisk(for encriptedKey: String) -> Data? {
        let filePath = self.filePath(key: encriptedKey)
        guard let nsData = NSData(contentsOf: filePath), self.fileManager.fileExists(atPath: filePath.path) else {
            return nil
        }
        return nsData as Data
    }

    
}
