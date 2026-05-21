//
//  FriendList.swift
//  FriendsFavoriteMovies
//
//  Created by Venkatesh Munaga on 21/05/26.
//

import SwiftUI
import SwiftData

struct FriendList: View {
    @Query(sort: \Friend.name) private var friends: [Friend]
    @Environment(\.modelContext) private var context
    
    @State private var name: String = ""
    
    var body: some View {
        NavigationSplitView {
            VStack {
                List(friends) { friend in
                    NavigationLink(friend.name) {
                        Text("Detail view for \(friend.name)")
                            .navigationTitle("Friend")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
                
                HStack {
                    TextField("Add friend name", text: $name)
                        .textFieldStyle(.roundedBorder)
                        .onSubmit {
                            if name.count > 2 {
                                context.insert(Friend(name: name))
                                name = ""
                            }
                        }
                    
                    Button("Add") {
                        if name.count > 2 {
                            context.insert(Friend(name: name))
                            name = ""
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
            .navigationTitle("Friends")
        } detail: {
            Text("Select a friend")
                .navigationTitle("Friend")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FriendList()
        .modelContainer(SampleData.shared.modelContainer)
}

