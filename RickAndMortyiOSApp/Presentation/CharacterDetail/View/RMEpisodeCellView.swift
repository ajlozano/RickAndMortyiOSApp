//
//  EpisodeCellView.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 8/4/25.
//

import SwiftUI

struct RMEpisodeCellView: View {
    @State var episode: RMEpisodeEntity
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color.white)
                .shadow(color: Color(.lightGray), radius: 1, x: 0, y: 2)
            VStack(alignment: .leading) {
                HStack {
                    Text(episode.episode ?? "")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.label))
                    Spacer()
                    Text(episode.airDate ?? "")
                        .font(.system(size: 16))
                        .italic()
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.gray))
                }
                Text(episode.name ?? "")
                    .font(.system(size: 16))
                    .fontWeight(.regular)
                    .foregroundColor(Color(.label))
                    .padding(.top, 5)
            }
            .padding(.horizontal)
        }
        .frame(height: 70)
    }
}

struct RMEpisodeCellViewContainer: View {
    @State var episode: RMEpisodeEntity
    
    var body: some View {
        RMEpisodeCellView(episode: episode)
    }
}

#Preview {
    let episodeEntity = RMEpisodeEntity(
        decodable: RMEpisodeDecodable(
            name: "Rickmurai Jack", airDate: "September 5, 2021", episode: "S05E10"))
    
    RMEpisodeCellViewContainer(episode: episodeEntity)
}
