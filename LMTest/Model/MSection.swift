//
//  MSection.swift
//  LMTest
//
//  Created by Виктория Воробьева on 19.04.2021.
//

import Foundation

struct MSection: Decodable, Hashable {
    let type: String
    let headerName: String
    let items: [MChat]
}

enum SectionHeaderName: Int, CaseIterable {
    case catalog
    case limited
    case bestPrice
}
