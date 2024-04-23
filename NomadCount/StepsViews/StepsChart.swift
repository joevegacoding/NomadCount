//
//  StepsChart.swift
//  NomadCount
//
//  Created by Joseph Bouhanef on 2024-04-23.
//

import Foundation
import Charts
import SwiftUI

 
// 10000
struct StepChart: View {
 @State private var todaysSteps = 3000
  @State private var stepsGoal = 10_000
  
  var body: some View {
    var stepsCount: [Steps] = [
     .init(steps: todaysSteps, date: Date(), color: .teal),
     .init(steps: stepsGoal - todaysSteps, date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, color: .teal.opacity(0.5))
   ]
    NavigationStack {
      VStack {
        Chart {
          ForEach(stepsCount) { step in
            
            SectorMark(angle: .value("Steps", step.steps), innerRadius: .ratio(0.618), angularInset: 2)
              .foregroundStyle(step.color)
              
          }
        }
        .frame(width: 300, height: 300)
        Spacer()
      }
      .padding()
      .navigationTitle("Chart")
  
    }
  }
}


#Preview {
  StepChart()
}
