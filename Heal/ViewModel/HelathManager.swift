//
//  HelathManager.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 26/05/2024.
//

import Foundation
import HealthKit

class HealthManager: ObservableObject {
    
    private let healthStore = HKHealthStore()
//    @Published var healthData: [HealthData] = []
    @Published var healthData: [String: HealthData] = [:]
    @Published var totalSteps: Double = 0
    @Published var totalDistance: Double = 0
    
    
    init() {
        requestAuthorization()
    }
    
    
    private func requestAuthorization() {
        let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
        let calories = HKQuantityType(.activeEnergyBurned)
        let readDataTypes: Set<HKObjectType> = [stepCountType, distanceType, calories]
        
        healthStore.requestAuthorization(toShare: nil, read: readDataTypes) { [weak self] success, error in
            if success {
                self?.fetchTodaySteps()
                self?.fetchTodayDistance()
                self?.fetchTodayCalories()
            } else {
                print("Authorization failed with error: \(String(describing: error))")
            }
        }
    }
    
     func fetchTodaySteps() {
        
        let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let predicate = HKQuery.predicateForSamples(withStart: .startOfToday, end: Date())
        
         let query = HKStatisticsQuery(quantityType: stepCountType , quantitySamplePredicate: predicate) { _, results, error in
            guard let quantity = results?.sumQuantity(), error == nil else {
                print("Error fetching steps data")
                return
            }
            
             let stepCount = quantity.doubleValue(for: .count())
             let data = HealthData(id: 0, type: .steps, value: "\(stepCount.formatedString())")
             DispatchQueue.main.async {
                 self.healthData["todaySteps"] = data
             }
            
        }
        healthStore.execute(query)
    }
    
    func fetchTodayCalories() {
        let calories = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfToday, end: Date())
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate) { _, result, error in
            
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("Error fetching calories data")
                return
            }
            
            let coloriesBurned = quantity.doubleValue(for: .kilocalorie())
            let data = HealthData(id: 1, type: .calories, value: "\(coloriesBurned.formatedString())")
            
            DispatchQueue.main.async  {
                self.healthData["todayCalories"] = data
            }
        
        }
        healthStore.execute(query)
    }
    
    func fetchTodayDistance() {
            let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
            let startDate = Calendar.current.startOfDay(for: Date())
            let endDate = Date()
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
            
            let query = HKStatisticsQuery(quantityType: distanceType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
                guard let quantity = result?.sumQuantity(), error == nil else {
                    print("Failed to fetch distance data with error: \(String(describing: error))")
                    return
                }
                
                let distance = quantity.doubleValue(for: .meter())
                let data = HealthData(id: 2, type: .distance, value: "\(distance.formattedKilometers())")
                
                DispatchQueue.main.async {
                    self.healthData["todayDistance"] = data
                }
                
            }
            
            healthStore.execute(query)
        }
    
}


extension Double {
    /// Converts the distance in meters to kilometers and returns it as a formatted string.
    func formattedKilometers() -> String {
        let kilometers = self / 1000
        return String(format: "%.2f", kilometers)
    }
    
    func formatedString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 0
        
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}

extension Date {
    static var startOfToday: Date {
        Calendar.current.startOfDay(for: Date())
    }
}
