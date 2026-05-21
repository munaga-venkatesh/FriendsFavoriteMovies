//
//  MovieList.swift
//  FriendsFavoriteMovies
//
//  Created by Venkatesh Munaga on 21/05/26.
//

import SwiftUI
import SwiftData

struct MovieList: View {
    @Query(sort: \Movie.title) private var movies: [Movie]
    @Environment(\.modelContext) private var context
    
    @State private var title: String = ""
    @State private var newDate: Date = .now
    
    var body: some View {
        NavigationSplitView {
            VStack {
                List(movies) { movie in
                    NavigationLink(movie.title) {
                        Text("Detail view for \(movie.title)")
                            .navigationTitle("Movie")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
                
                VStack {
                    DatePicker(
                        selection: $newDate,
                        in: Date.distantPast...Date.distantFuture,
                        displayedComponents: .date
                    ) {
                        TextField("Add title", text: $title)
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    Button("Add") {
                        if title.count >= 2 {
                            context.insert(Movie(title: title, releaseDate: newDate))
                            title = ""
                        }
                    }
                    .bold()
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .buttonStyle(.bordered)
                    .tint(.accentColor)
                }
                .padding()
            }
            .navigationTitle("Movies")
        } detail: {
            Text("Select a Moive")
                .navigationTitle("Movie")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MovieList()
        .modelContainer(SampleData.shared.modelContainer)
}
