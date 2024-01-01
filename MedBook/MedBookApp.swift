//
//  MedBookApp.swift
//  MedBook
//
//  Created by Ananya Joshi on 31/12/23.
//

import SwiftUI

@main
struct MedBookApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
