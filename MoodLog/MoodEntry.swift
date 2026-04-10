//
//  MoodEntry.swift
//  MoodLog
//
//  Created by Ignacio Lagos Morales on 27-03-26.
//

import Foundation
import SwiftData

public enum MoodType: String, CaseIterable, Codable{
    
    case concentrado = "Concentrado"
    case motivado = "Motivado"
    case cansado = "Cansado"
    case bloqueado = "Bloqueado"
    case neutral = "Neutral"
}

@Model
class MoodEntry{
    var date: Date
    var moodType: MoodType
    var notes: String?
    
    init(date: Date, moodType: MoodType, notes: String? = nil)
    {
        self.date = date
        self.moodType = moodType
        self.notes = notes
    }
}
