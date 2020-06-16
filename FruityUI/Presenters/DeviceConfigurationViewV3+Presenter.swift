//
//  DeviceConfigurationViewV3+Presenter.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 07/06/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import FruityKit

extension DeviceConfigurationViewV3 {
    
    class Presenter: ObservableObject {
        
        enum Action {
            
            case commit
            case dismissError
            case setRawConfiguration(String)
        }
        
        let device: Device
        let engine: Engine
        
        @Published var rawConfiguration: String = ""
        @Published var showingError = false
        
        var error: String? {
            didSet {
                if error != nil {
                    showingError = true
                } else {
                    showingError = false
                }
            }
        }
        
        init(device: Device, engine: Engine) {
            self.device = device
            self.engine = engine
            
            if let storedConfiguration = DeviceConfigurationV3.get(forDeviceWithShortName: device.shortName) {
                let converter = DeviceRawDataConverter(colors: storedConfiguration.colors)
                
                rawConfiguration = converter.json
            }
        }
        
        func perform(_ action: Action) {
            switch action {
            case .commit:
                guard let razerDevice = device.razerDevice else {
                    assertionFailure("`razerDevice` should never be nil on a non-stub device driver.")
                    
                    return
                }
                
                guard case let Driver.v3(driver: handle) = razerDevice.driver else {
                    assertionFailure("Driver should be of Synapse2 type.")
                    
                    return
                }
                
                guard let converter = DeviceRawDataConverter(json: rawConfiguration) else {
                    error = "Your input wasn't accepted by the driver. Please refer to the documentation to learn how to build a raw data input for your device."
                    
                    return
                }
                
                guard handle.write(mode: converter.mode) else {
                    error = "An error has occurred while setting the selected mode.\n\nMaybe this mode isn't supported by your device?"
                    
                    return
                }
                
                engine.persistence.setMode(converter.mode, forDeviceWithShortName: device.shortName)
                
            case .dismissError:
                error = nil
                
            case .setRawConfiguration(let configuration):
                rawConfiguration = configuration
            }
        }
    }
}
