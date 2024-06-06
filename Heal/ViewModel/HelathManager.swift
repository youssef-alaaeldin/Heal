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
    @Published var goalAchieved = false
    @Published var standingTimeDaily: Double = 0
    
    @Published var standingTimeWeekly: Double = 0
    
    @Published var standingTimeMonthly: Double = 0
    
    @Published var standingGoal: Double = 12 // Example goal: 12 hours
        
        // Existing methods...

        
    
    let dailyStepsGoal: Double = 1000
    
    init() {
        requestAuthorization()
    }
    
    
    private func requestAuthorization() {
        let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
        let calories = HKQuantityType(.activeEnergyBurned)
        let heartRate = HKQuantityType(.heartRate)
        let heightType = HKQuantityType(.height)
        let bodyMassType = HKQuantityType(.bodyMass)
        let standHourType = HKQuantityType(.appleStandTime)
        let readDataTypes: Set<HKObjectType> = [
            stepCountType,
            distanceType,
            calories,
            heartRate,
            heightType,
            bodyMassType,
            standHourType,
            HKObjectType.characteristicType(forIdentifier: .bloodType)!,
            HKObjectType.characteristicType(forIdentifier: .biologicalSex)!
        ]
        
        healthStore.requestAuthorization(toShare: nil, read: readDataTypes) { [weak self] success, error in
            if success {
                self?.fetchTodayData()
                self?.fetchWeeklyData()
                self?.fetchMonthlyData()
                self?.fetchUserCharacteristics()
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
        fetchStandHours(startDate: .startOfToday, endDate: Date(), key: "DailyStanding")
    }
    
    func fetchWeeklyData() {
        fetchSteps(startDate: .startOfWeek, endDate: Date(), key: "WeeklySteps")
        fetchCalories(startDate: .startOfWeek, endDate: Date(), key: "WeeklyCalories")
        fetchDistance(startDate: .startOfWeek, endDate: Date(), key: "WeeklyDistance")
        fetchHeartRate(startDate: .startOfWeek, endDate: Date(), key: "WeeklyHeartRate")
        fetchStandHours(startDate: .startOfWeek, endDate: Date(), key: "WeeklyStanding")
    }
    
    func fetchMonthlyData() {
        fetchSteps(startDate: .startOfMonth, endDate: Date(), key: "MonthlySteps")
        fetchCalories(startDate: .startOfMonth, endDate: Date(), key: "MonthlyCalories")
        fetchDistance(startDate: .startOfMonth, endDate: Date(), key: "MonthlyDistance")
        fetchHeartRate(startDate: .startOfMonth, endDate: Date(), key: "MonthlyHeartRate")
        fetchStandHours(startDate: .startOfMonth, endDate: Date(), key: "MonthlyStanding")
        
//        DispatchQueue.main.async {
//            self.healthData = self.healthData.filter { $0.key.contains("monthly") }
//        }
    }
    
     func fetchSteps(startDate: Date, endDate: Date, key: String) {
        
        let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        
         let query = HKStatisticsQuery(quantityType: stepCountType , quantitySamplePredicate: predicate) { _, results, error in
            guard let quantity = results?.sumQuantity(), error == nil else {
                print("Error fetching steps data at date \(startDate) error: \(String(describing: error))")
                return
            }
            
             let stepCount = quantity.doubleValue(for: .count())
             let data = HealthData(id: UUID(), type: .steps, value: "\(Int(stepCount))")
             DispatchQueue.main.async {
                 self.healthData[key] = data
                 if startDate == .startOfToday {
                     self.totalSteps = stepCount
                 }
                 self.checkGoalAchievement()
             }
            
        }
        healthStore.execute(query)
    }
    
    func fetchCalories(startDate: Date, endDate: Date, key: String) {
        let calories = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate) { _, result, error in
            
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("Error fetching calories data at date \(startDate) error: \(String(describing: error))")
                return
            }
            
            let coloriesBurned = quantity.doubleValue(for: .kilocalorie())
            let data = HealthData(id: UUID(), type: .calories, value: "\(Int(coloriesBurned))")
            
            print("Calories: \(Int(coloriesBurned)) at date : \(startDate)")
            
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
                
                print("Distance: \(distance.formattedKilometers()) at date \(startDate)")
                
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
                print("Error fetching heart rate at date \(startDate) error: \(String(describing: error))")
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
    
    func fetchUserCharacteristics() {
            fetchBiologicalSex()
            fetchBloodType()
            fetchMostRecentSample(for: HKQuantityType.quantityType(forIdentifier: .height)!) { height in
                if let height = height {
                    let heightData = HealthData(id: UUID(), type: .height, value: "\(height.formatedString())")
                    DispatchQueue.main.async {
                        self.healthData["Height"] = heightData
                    }
                }
            }
            fetchMostRecentSample(for: HKQuantityType.quantityType(forIdentifier: .bodyMass)!) { weight in
                if let weight = weight {
                    let weightData = HealthData(id: UUID(), type: .weight, value: "\(weight.formatedString())")
                    DispatchQueue.main.async {
                        self.healthData["Weight"] = weightData
                    }
                    if let height = self.healthData["Height"]?.value, let heightValue = Double(height) {
                        let bmiValue = weight / (heightValue * heightValue)
                        let bmiData = HealthData(id: UUID(), type: .bmi, value: "\(bmiValue.formatedString())")
                        print(bmiValue)
                        DispatchQueue.main.async {
                            self.healthData["BMI"] = bmiData
                        }
                    }
                }
            }
        
        }
        
        private func fetchBiologicalSex() {
            do {
                let biologicalSexObject = try healthStore.biologicalSex()
                let biologicalSexData = HealthData(id: UUID(), type: .biologicalSex, value: biologicalSexObject.biologicalSex.stringRepresentation)
                DispatchQueue.main.async {
                    self.healthData["BiologicalSex"] = biologicalSexData
                }
            } catch {
                print("Failed to fetch biological sex with error: \(error)")
            }
        }
        
        private func fetchBloodType() {
            do {
                let bloodTypeObject = try healthStore.bloodType()
                let bloodTypeData = HealthData(id: UUID(), type: .bloodType, value: bloodTypeObject.bloodType.stringRepresentation)
                DispatchQueue.main.async {
                    self.healthData["BloodType"] = bloodTypeData
                }
            } catch {
                print("Failed to fetch blood type with error: \(error)")
            }
        }
        
        private func fetchMostRecentSample(for sampleType: HKSampleType, completion: @escaping (Double?) -> Void) {
            let predicate = HKQuery.predicateForSamples(withStart: Date.distantPast, end: Date(), options: .strictEndDate)
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
            
            let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: 1, sortDescriptors: [sortDescriptor]) { _, result, error in
                if let error = error {
                    print("Error fetching sample \(sampleType): \(error.localizedDescription)")
                    completion(nil)
                } else if let result = result?.first as? HKQuantitySample {
                    let unit = sampleType == HKQuantityType.quantityType(forIdentifier: .height) ? HKUnit.meter() : HKUnit.gram()
                    completion(result.quantity.doubleValue(for: unit))
                } else {
                    completion(nil)
                }
            }
            healthStore.execute(query)
        }
    
    func fetchStandHours(startDate: Date, endDate: Date, key: String) {
        let standHourType = HKQuantityType(.appleStandTime)
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
            let query = HKStatisticsQuery(quantityType: standHourType, quantitySamplePredicate: predicate) { _, result, error in
                guard let quantity = result?.sumQuantity(), error == nil else {
                    print("Error fetching stand hours data at date \(startDate) error: \(String(describing: error))")
                    return
                }
                
                
                let standHours = quantity.doubleValue(for: .hour())
                print(standHours)
                DispatchQueue.main.async {
                    if startDate == .startOfToday {
                        self.standingTimeDaily = standHours
                    }
                    if startDate == .startOfWeek {
                        self.standingTimeWeekly = standHours
                    }
                    if startDate == .startOfMonth {
                        self.standingTimeMonthly = standHours
                    }
                }
            }
            healthStore.execute(query)
        }
    
    func standingProgress(for period: HealthPeriod) -> Double {
        switch period {
        case .Daily:
            return min(standingTimeDaily / standingGoal * 100, 100)
        case .Weekly:
            return min(standingTimeWeekly / (standingGoal * 7) * 100, 100)
        case .Monthly:
            return min(standingTimeMonthly / (standingGoal * 30) * 100, 100)
        }
    }
    
    
    private func setupDailyGoalReset() {
            let midnight = Calendar.current.startOfDay(for: Date().addingTimeInterval(86400))
            let timer = Timer(fireAt: midnight, interval: 86400, target: self, selector: #selector(resetDailyGoal), userInfo: nil, repeats: true)
            RunLoop.main.add(timer, forMode: .default)
        }
        
        @objc private func resetDailyGoal() {
            self.totalSteps = 0
            self.goalAchieved = false
            fetchTodayData()
        }
        
        private func checkGoalAchievement() {
            if totalSteps >= dailyStepsGoal && !goalAchieved {
                goalAchieved = true
            }
        }
}



