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
        let heartRate = HKQuantityType(.heartRate)
        let readDataTypes: Set<HKObjectType> = [stepCountType, distanceType, calories, heartRate]
        
        healthStore.requestAuthorization(toShare: nil, read: readDataTypes) { [weak self] success, error in
            if success {
                self?.fetchTodayData()
                self?.fetchWeeklyData()
                self?.fetchMonthlyData()
            } else {
                print("Authorization failed with error: \(String(describing: error))")
            }
        }
    }
    
    
    func fetchTodayData() {
        fetchSteps(startDate: .startOfToday, endDate: Date(), key: "DailySteps")
        fetchCalories(startDate: .startOfToday, endDate: Date(), key: "DailyCalories")
        fetchDistance(startDate: .startOfToday, endDate: Date(), key: "DailyDistance")
        fetchHeartRate(startDate: .startOfToday, endDate: Date(), key: "DailyHeartRate")
//
//        DispatchQueue.main.async {
//            self.healthData = self.healthData.filter { $0.key.contains("today") }
//        }
    }
    
    func fetchWeeklyData() {
        fetchSteps(startDate: .startOfWeek, endDate: Date(), key: "WeeklySteps")
        fetchCalories(startDate: .startOfWeek, endDate: Date(), key: "WeeklyCalories")
        fetchDistance(startDate: .startOfWeek, endDate: Date(), key: "WeeklyDistance")
        fetchHeartRate(startDate: .startOfToday, endDate: Date(), key: "WeeklyHeartRate")
        
//        DispatchQueue.main.async {
//            self.healthData = self.healthData.filter { $0.key.contains("weekly") }
//        }
    }
    
    func fetchMonthlyData() {
        fetchSteps(startDate: .startOfMonth, endDate: Date(), key: "MonthlySteps")
        fetchCalories(startDate: .startOfMonth, endDate: Date(), key: "MonthlyCalories")
        fetchDistance(startDate: .startOfMonth, endDate: Date(), key: "MonthlyDistance")
        fetchHeartRate(startDate: .startOfToday, endDate: Date(), key: "MonthlyHeartRate")
        
//        DispatchQueue.main.async {
//            self.healthData = self.healthData.filter { $0.key.contains("monthly") }
//        }
    }
    
     func fetchSteps(startDate: Date, endDate: Date, key: String) {
        
        let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        
         let query = HKStatisticsQuery(quantityType: stepCountType , quantitySamplePredicate: predicate) { _, results, error in
            guard let quantity = results?.sumQuantity(), error == nil else {
                print("Error fetching steps data")
                return
            }
            
             let stepCount = quantity.doubleValue(for: .count())
             let data = HealthData(id: UUID(), type: .steps, value: "\(stepCount.formatedString())")
             DispatchQueue.main.async {
                 self.healthData[key] = data
             }
            
        }
        healthStore.execute(query)
    }
    
    func fetchCalories(startDate: Date, endDate: Date, key: String) {
        let calories = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate) { _, result, error in
            
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("Error fetching calories data")
                return
            }
            
            let coloriesBurned = quantity.doubleValue(for: .kilocalorie())
            let data = HealthData(id: UUID(), type: .calories, value: "\(Int(coloriesBurned))")
            
            DispatchQueue.main.async  {
                self.healthData[key] = data
            }
            
            
            
        }
        healthStore.execute(query)
    }
    
    func fetchDistance(startDate: Date, endDate: Date, key: String) {
            let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
            
            let query = HKStatisticsQuery(quantityType: distanceType, quantitySamplePredicate: predicate) { _, result, error in
                guard let quantity = result?.sumQuantity(), error == nil else {
                    print("Failed to fetch distance data with error: \(String(describing: error))")
                    return
                }
                
                let distance = quantity.doubleValue(for: .meter())
                let data = HealthData(id: UUID(), type: .distance, value: "\(distance.formattedKilometers())")
                
                print(distance.formattedKilometers())
                
                DispatchQueue.main.async {
                    self.healthData[key] = data
                }
                
            }
            
            healthStore.execute(query)
        }
    
    func fetchHeartRate(startDate: Date, endDate: Date, key: String) {
        let heartRate = HKQuantityType(.heartRate)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let sortDiscr = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let query = HKSampleQuery(sampleType: heartRate, predicate: predicate, limit: Int(HKObjectQueryNoLimit), sortDescriptors: [sortDiscr]) { _, result, error in
            guard let quantity = result,  error == nil else {
                print("Error fetching heart rate \(error.debugDescription)")
                return
            }
            if quantity.isEmpty {
                print("Error fetching heart rate array is empty")
                return
            }
            
            if let data = quantity[0] as? HKQuantitySample {
                let unit = HKUnit(from: "count/min")
                let latestHeartRate = data.quantity.doubleValue(for: unit)
                
                let fetchedData = HealthData(id: UUID(), type: .heartRate, value: "\(Int(latestHeartRate))")
                DispatchQueue.main.async {
                    self.healthData[key] = fetchedData
                }
            }
//            guard let data = quantity[0] as? HKQuantitySample else {
//                print("Error ")
//                return
//            }
//
        }
        healthStore.execute(query)
    }
    
}


extension Double {
    
    func formattedCalories() -> String {
        String(format: "%.2f", self)
    }
    
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
    
    static var startOfWeek: Date {
        Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
    }
    
    static var startOfMonth: Date {
        let components = Calendar.current.dateComponents([.year, .month], from: Date())
        return Calendar.current.date(from: components)!
    }
}
