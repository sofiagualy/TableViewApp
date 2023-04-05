//
//  ViewController.swift
//  TableStory
//
//  Created by Gualy, Sofia on 3/22/23.
//

import UIKit
import MapKit
let data = [
    Item(name: "Babes Doughnut Co.", neighborhood: "Downtown", desc: "Breakfast and Coffee", lat: 29.883820, long: -97.940010, imageName: "babes"),
    Item(name: "Blue Dahlia Bistro", neighborhood: "Downtown", desc: "European Bistro", lat: 29.883370, long: -97.941180, imageName: "blue dahlia"),
    Item(name: "Cafe on the Square", neighborhood: "Downtown", desc: "American Cafe", lat: 29.883010, long: -97.939860, imageName: "cafe"),
    Item(name: "CRAFThouse Kitchen and Tap", neighborhood: "Downtown", desc: "Pub Fare and Drinks ", lat: 29.884260, long: -97.940110, imageName: "craft"),
    Item(name: "Ikes Love and Sandwiches", neighborhood: "Downtown", desc: "Unique Sandwiches", lat: 29.884530, long: -97.942160, imageName: "ikes")
   
]

struct Item {
    var name: String
    var neighborhood: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var theTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        let item = data[indexPath.row]
        cell?.textLabel?.text = item.name
        
        let image = UIImage(named: item.imageName)
                    cell?.imageView?.image = image
                    cell?.imageView?.layer.cornerRadius = 10
                    cell?.imageView?.layer.borderWidth = 5
                    cell?.imageView?.layer.borderColor = UIColor.white.cgColor
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let item = data[indexPath.row]
      performSegue(withIdentifier: "ShowDetailSegue", sender: item)
    
  }
    
    @IBOutlet weak var mapView: MKMapView!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "ShowDetailSegue" {
               if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                   // Pass the selected item to the detail view controller
                   detailViewController.item = selectedItem
               }
           }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        theTable.delegate = self
        theTable.dataSource = self

        
        //add this code in viewDidLoad function in the original ViewController, below the self statements

          //set center, zoom level and region of the map
              let coordinate = CLLocationCoordinate2D(latitude: 30.295190, longitude: -97.7444)
              let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
              mapView.setRegion(region, animated: true)
              
           // loop through the items in the dataset and place them on the map
               for item in data {
                  let annotation = MKPointAnnotation()
                  let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                  annotation.coordinate = eachCoordinate
                      annotation.title = item.name
                      mapView.addAnnotation(annotation)
                      }

        // Do any additional setup after loading the view.
    }


}

