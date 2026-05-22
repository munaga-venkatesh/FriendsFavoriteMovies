//
//  MovieDetail.swift
//  FriendsFavoriteMovies
//
//  Created by Venkatesh Munaga on 22/05/26.
//

import SwiftUI

struct MovieDetail: View {
    @Bindable var movie: Movie
    
    var body: some View {
        Form {
            TextField(movie.title, text: $movie.title)
                .autocorrectionDisabled()
            
            DatePicker("Release date", selection: $movie.releaseDate, displayedComponents: .date)
        }
        .navigationTitle("Movie")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        MovieDetail(movie: SampleData.shared.movie)
    }
}
