//
//  RealmObjectObservationToken.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 28/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation
import RealmSwift

class RealmObjectObservationToken: FavoritesDatabaseObservationToken {
    
    // MARK: - Private Properties
    
    private let realmNotificationToken: NotificationToken
    
    // MARRK: - Initialization
    
    /// Initiazes a Realm notification token.
    ///
    /// - Parameter realmNotificationToken: A Realm notification token instance.
    init(realmNotificationToken: NotificationToken) {
        self.realmNotificationToken = realmNotificationToken
    }
    
    /// Invalidates the notification token.
    func invalidate() {
        realmNotificationToken.invalidate()
    }
    
}
