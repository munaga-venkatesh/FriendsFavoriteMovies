//
//  SampleData.swift
//  FriendsFavoriteMovies
//
//  Created by Venkatesh Munaga on 21/05/26.
//

import Foundation
import SwiftData

@MainActor
class SampleData {
    static let shared = SampleData()
    
    let modelContainer: ModelContainer
    
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    var friend: Friend {
        Friend.sampleData.first ?? Friend(name: "Venkatesh")
    }
    
    var movie: Movie {
        Movie.sampleData.first ?? Movie(title: "Movie Name", releaseDate: Date.now)
    }
    
    private init() {
        let schema = Schema([
            Friend.self,
            Movie.self,
        ])
        
        let modelConfigration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfigration])
            
            insertSampleData()
            
            try context.save()
        } catch {
            fatalError("Couldn't able to create a Model Continer \(error)")
        }
    }
    
    private func insertSampleData() {
        for friend in Friend.sampleData {
            context.insert(friend)
        }
        
        for movie in Movie.sampleData {
            context.insert(movie)
        }
    }
}
