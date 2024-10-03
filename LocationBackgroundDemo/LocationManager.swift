//
//  LocationManager.swift
//  LocationBackgroundDemo
//
//  Created by Marco Alonso on 02/10/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    
    private override init() {
        super.init()
        
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.distanceFilter = kCLDistanceFilterNone
    }
    
    func requestLocationPermision() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    func startBackgroundLocationUpdates() {
        locationManager.startUpdatingLocation()
        print("Iniciando actualizaciones de ubicación en segundo plano")
    }
    
    func stopLocationUpdates() {
        locationManager.stopUpdatingLocation()
        print("Deteniendo actualizaciones de ubicación")
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        print("Nueva ubicación obtenida en segundo plano: \(location.coordinate.latitude), \(location.coordinate.longitude)")
    }
    
    /// GPS este desactivado
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error al obtener la ubicación: \(error.localizedDescription)")
    }
    
    /// Identificar cuando se cambias los permisos
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways:
            print("Permiso de ubicación siempre concedido")
        case .authorizedWhenInUse:
            print("Permiso de ubicación concedido solo en uso")
        case .denied, .restricted:
            print("Permiso de ubicación denegado o restringido")
        case .notDetermined:
            print("Permiso de ubicación no determinado")
        @unknown default:
            print("Estado de autorización desconocido")
        }
    }
    
}
