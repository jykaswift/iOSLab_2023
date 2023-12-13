//
//  Note.swift
//  TableViewDiffable
//
//  Created by Евгений Борисов on 15.11.2023.
//

import Foundation

struct Note: Hashable, Identifiable {
    var id = UUID()
    var name: String
    var description: String
}
