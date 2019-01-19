//
//  ViewController.swift
//  HubAssignment
//
//  Created by Syed, Azharuddin on 1/17/19.
//  Copyright © 2019 Syed, Azharuddin. All rights reserved.
//

import UIKit
import CoreData

class ForecastVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @objc var forecastServiceWrapper: ForecastServiceWrapper!
    @objc var coreDataStack: CoreDataStack!
    var cellManager: ForecastVCCellManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        cellManager = ForecastVCCellManager(collectionView).setDelegateDatasource()
        cellManager.delegate = self
    }
    
    func downloadAndSaveForecast(for location:Location, and metrics:Metrics) {
        forecastServiceWrapper.getForeCast(forMetrics: metrics, location: location) { (whether) in
            
            let entity = NSEntityDescription.entity(forEntityName: "MetricLocationEntity", in: self.coreDataStack.backgroundContext)
            let metricLocationEntity = MetricLocationEntity(entity: entity!, insertInto: self.coreDataStack.backgroundContext)
           metricLocationEntity.location = location.rawValue
           metricLocationEntity.metric = metrics.rawValue
            
           metricLocationEntity.weatherForcast = whether
            self.coreDataStack.saveContext(self.coreDataStack.backgroundContext)
        }
    }
}

//MARK:- ForecastVCCellManagerDelegate
extension ForecastVC: ForecastVCCellManagerDelegate {
    func didSelectDownload(for location: Location, metrics: Metrics) {
        self.downloadAndSaveForecast(for: location, and: metrics)
    }
}

