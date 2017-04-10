//
//  MapsController.swift
//  Yelp
//
//  Created by Yerneni, Naresh on 4/9/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class MapsController: UIViewController,MKMapViewDelegate {

     var businesses: [Business]!
    
    @IBOutlet weak var mkMapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        super.viewDidLoad()
        
        navigationItem.titleView?.tintColor = UIColor.white
        
        mkMapView.delegate = self
        mkMapView.setRegion(MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), MKCoordinateSpanMake(0.05, 0.05)), animated: false)
        mkMapView.setCenter(CLLocationCoordinate2DMake(37.783333, -122.416667), animated: true)
        appendAllBizPins()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mkMapView.setRegion(region, animated: false)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
       
        let pTitle = ((view.annotation?.subtitle)!)!
        let index = Int.init(pTitle)
        let bIndex = index! - 1
        
        let views = Bundle.main.loadNibNamed("pinDetails", owner: nil, options: nil)
        let bizDetails = views?[0] as! pinDetails
        
        let businessObj = businesses[bIndex]
        
        bizDetails.businessNameLabel.text = businessObj.name
        bizDetails.addressLabel.text = businessObj.address
        
        if businessObj.ratingSmallImageURL != nil {
            bizDetails.ratingImageView.setImageWith(businessObj.ratingSmallImageURL!)
        }
        bizDetails.reviewLabel.text = "\(businessObj.reviewCount!) Reviews"
        bizDetails.categoriesLabel.text = businessObj.categories
        bizDetails.distanceLabel.text = businessObj.distance
        
        bizDetails.center = CGPoint(x: view.bounds.size.width / 2, y: -bizDetails.bounds.size.height*0.52)
        view.addSubview(bizDetails)
        mkMapView.setCenter((view.annotation?.coordinate)!, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: MKAnnotationView.self)
        {
            for subview in view.subviews
            {
                subview.removeFromSuperview()
            }
        }
    }
    
    func appendAllBizPins(){
        var index = 0
        for businessObj in businesses{
            index += 1
            addPin(lat: businessObj.locationCoordinates.lat, longitude: businessObj.locationCoordinates.longitude,itmIndex: index )
        }
    }
    
    func addPin(lat: Double, longitude: Double, itmIndex: Int) {
        let annotation = MKPointAnnotation()
        let locationCoordinate = CLLocationCoordinate2DMake(lat, longitude)
        annotation.coordinate = locationCoordinate
        
        annotation.subtitle = "\(itmIndex)"
        mkMapView.addAnnotation(annotation)
    }
    
    
    @IBAction func goHome(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    
}
