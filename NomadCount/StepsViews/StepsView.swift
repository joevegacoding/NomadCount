//
//  ContentView.swift
//  NomadCount
//
//  Created by Joseph Bouhanef on 2024-04-10.
//

import SwiftUI
import Charts

struct StepsView: View {
    @State private var steps: [Double] = Array(repeating: 0, count: 7)
    var healthStore = HealthStore()
    
    var body: some View {
        VStack {

            ForEach(0..<steps.count, id: \.self) { day in
                Text("\(formattedDateFor(day: day)): \(Int(steps[day]))")
            }
        }
        .onAppear {
            healthStore.requestAuthorization { authorized in
                if authorized {
                    fetchStepsData()
                }
            }
        }
    }

    private func fetchStepsData() {
        let today = Date()
        for day in 0..<steps.count {
            let dayDate = Calendar.current.date(byAdding: .day, value: -day, to: today)!
            healthStore.getSteps(for: dayDate) { stepCount in
                DispatchQueue.main.async {
                    self.steps[day] = stepCount
                }
            }
        }
    }

    private func formattedDateFor(day: Int) -> String {
        let date = Calendar.current.date(byAdding: .day, value: -day, to: Date())!
        return date.formatted(date: .long, time: .omitted)
    }
}

