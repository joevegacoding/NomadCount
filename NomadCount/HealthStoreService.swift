//
//  HealthStoreService.swift
//  NomadCount
//
//  Created by Joseph Bouhanef on 2024-04-10.
//
import HealthKit

class HealthStore {
    var healthStore: HKHealthStore?

    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }

    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        guard let stepsCount = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            return completion(false)
        }

        healthStore?.requestAuthorization(toShare: [], read: [stepsCount]) { success, error in
            completion(success)
        }
    }
}


extension HealthStore {
  func getSteps(for date: Date, completion: @escaping (Double) -> Void) {
      guard let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
          return
      }

      let calendar = Calendar.current
      let startOfDay = calendar.startOfDay(for: date)
      let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!

      let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)

      let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, statistics, _ in
          let sum = statistics?.sumQuantity()?.doubleValue(for: .count()) ?? 0
          DispatchQueue.main.async {
              completion(sum)
          }
      }

      healthStore?.execute(query)
  }


}
