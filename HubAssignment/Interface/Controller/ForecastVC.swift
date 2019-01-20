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
    @IBOutlet weak var toastViewHeight: NSLayoutConstraint! {
        didSet {
            toastViewHeight.constant = 0
        }
    }
    @IBOutlet weak var toastView: UIView!
    @objc var forecastServiceWrapper: ForecastServiceWrapper!
    @objc var coreDataStack: CoreDataStack!
    var cellManager: ForecastVCCellManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        cellManager = ForecastVCCellManager(collectionView).setDelegateDatasource()
        cellManager.delegate = self
    }
    
    func downloadAndSaveForecast(for location:Location, and metrics:Metrics) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        forecastServiceWrapper.getForeCast(forMetrics: metrics, location: location) {[weak self] (whether) in
            guard let strongSelf = self else {
                return
            }
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            let context = strongSelf.coreDataStack.backgroundContext
            let entity = NSEntityDescription.entity(forEntityName: "MetricLocationEntity", in: context)
            let metricLocationEntity = MetricLocationEntity(entity: entity!, insertInto: context)
            metricLocationEntity.location = location.rawValue
            metricLocationEntity.metric = metrics.rawValue
            metricLocationEntity.addWeatherForecast(whether, into: context)
            strongSelf.coreDataStack.saveContext(context)
            
            strongSelf.showToastView()
        }
    }
    
    func showToastView() {
        DispatchQueue.main.async {
            self.toastView.isHidden = false
            UIView.animate(withDuration: 0.25, animations: {
                self.toastViewHeight.constant = 50
                self.toastView.layoutIfNeeded()
            })
        }
    }
    
    @IBAction func printDownloaded(_ sender: Any) {
      let fetch = MetricLocationEntity.fetchRequest1()
      fetch.returnsObjectsAsFaults = false
        
        do {
            let results = try self.coreDataStack.viewContext.fetch(fetch) as [MetricLocationEntity]
            
            for result in results {
                print("Location ", result.location)
                print("metric ", result.metric)
                if let weatherForcasts = result.weatherForcast {
                    for forecast in weatherForcasts {
                        guard let weatherForecastEnity = forecast as? WeatherForcastEntity else {
                            continue
                        }
                        print("month ", weatherForecastEnity.month)
                        print("year ", weatherForecastEnity.year)
                        print("value ", weatherForecastEnity.value)
                    }
                }
                
            }
           
        }catch {
            print(error)
        }
      
    }
    
}

//MARK:- ForecastVCCellManagerDelegate
extension ForecastVC: ForecastVCCellManagerDelegate {
    func didSelectDownload(for location: Location, metrics: Metrics) {
        self.downloadAndSaveForecast(for: location, and: metrics)
    }
}

