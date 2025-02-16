//
//  SearchView.swift
//  campus-foodtruck-finder
//
//  Created by 陈昱桦 on 2/15/25.
//

import SwiftUI
import CoreLocation

struct SearchBar: UIViewRepresentable {
    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}

struct SearchView: View {
    @ObservedObject var viewModel: FoodTruckViewModel
    @StateObject private var locationManager = LocationManager()
    @State private var searchText = ""

    var body: some View {
        ScrollView {
            VStack {
                SearchBar(text: $searchText)
                FoodTruckListView(
                    viewModel: viewModel,
                    searchText: $searchText,
                    userLocation: locationManager.location
                )
            }
        }
        .scrollDismissesKeyboard(.interactively)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = FoodTruckViewModel()
        SearchView(viewModel: viewModel)
    }
}
