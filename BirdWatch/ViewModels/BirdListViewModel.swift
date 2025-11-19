//
//  BirdListViewModel.swift
//  BirdWatch
//
//  Created by Asen Ou on 11/19/25.
//

import Foundation

class BirdListViewModel: ObservableObject {

    @Published var birds: [Bird] = dummyData

    // We can define functions underneath as we add more functionality to the View
}
