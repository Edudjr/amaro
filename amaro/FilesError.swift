//
//  FilesError.swift
//  amaro
//
//  Created by Rafael Aramizu Gomes on 09/12/2017.
//  Copyright © 2017 Eduardo Domene Junior. All rights reserved.
//
import Foundation

enum FilesError: Error {
    case notFound
    case malformed
}

extension FilesError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case .notFound:
            return NSLocalizedString("File was not found", comment: "File not found")
        case .malformed:
            return NSLocalizedString("Malformed JSON", comment: "Maformed")
        }
    }
}
