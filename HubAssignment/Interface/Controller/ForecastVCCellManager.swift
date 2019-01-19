//
//  ForecastVCCellManager.swift
//  HubAssignment
//
//  Created by Syed, Azharuddin on 1/18/19.
//  Copyright © 2019 Syed, Azharuddin. All rights reserved.
//

import UIKit

protocol ForecastVCCellManagerDelegate: class {
    func didSelectDownload(for location: Location, metrics: Metrics)
}

class ForecastVCCellManager: NSObject {
    let collectionView: UICollectionView
    let layout:[(location: Location, metrics: [Metrics])] = [
        (Location.uk, [.tmax, .tmin, .rainfall]),
        (Location.england, [.tmax, .tmin, .rainfall]),
        (Location.wales, [.tmax, .tmin, .rainfall]),
        (Location.scotland, [.tmax, .tmin, .rainfall])
    ]
    weak var delegate: ForecastVCCellManagerDelegate?
    
    init(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
       super.init()
    }
    
    func setDelegateDatasource() -> Self {
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        return self
    }
    
    func getMetricsLocation(from indexPath:IndexPath) -> (location:Location, metrics:Metrics) {
        let location = layout[indexPath.section - 1]
        let metricIndex = location.metrics[indexPath.row - 1]
        return (location.location, metricIndex)
    }
    
    func getColumnName(for indexPath:IndexPath) -> String {
        let columName = "download"
        
        if indexPath.row == 0 {
            return layout[indexPath.section - 1].location.rawValue
        }else if indexPath.section == 0 {
            return layout.first?.metrics[indexPath.row - 1].rawValue ?? columName
        }
        
        return columName
    }
}

//MARK:- DataSource
extension ForecastVCCellManager: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  (layout.first?.metrics.count ?? 0) + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath)
        let label = cell.viewWithTag(111) as? UILabel
        
        label?.text = indexPath == IndexPath(item: 0, section: 0) ? "Region" : getColumnName(for: indexPath)
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return layout.count + 1
    }
}

//MARK:- Delegate
extension ForecastVCCellManager: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let shouldSelect =  indexPath.section != 0 && indexPath.row != 0 ? true : false
        return shouldSelect
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.didSelectDownload(for: self.getMetricsLocation(from: indexPath).location, metrics: self.getMetricsLocation(from: indexPath).metrics)
    }
}
