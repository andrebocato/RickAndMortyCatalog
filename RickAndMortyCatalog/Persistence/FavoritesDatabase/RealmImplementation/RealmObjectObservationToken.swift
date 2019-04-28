//
//  RealmObjectObservationToken.swift
//  RickAndMortyCatalog
//
//  Created by Eduardo Sanches Bocato on 28/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation
import RealmSwift

class RealmObjectObservationToken: FavoritesDatabaseObservationToken {
    
    // MARK: - Private Properties
    
    private let realmNotificationToken: NotificationToken
    
    // MARk:
    
    /// Initiazes
    ///
    /// - Parameter realmNotificationToken: A realm notification token instance.
    init(realmNotificationToken: NotificationToken) {
        self.realmNotificationToken = realmNotificationToken
    }
    
    /// Invalidates the notification token
    func invalidate() {
        realmNotificationToken.invalidate()
    }
    
}
