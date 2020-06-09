//
//  DeviceConfigurationViewV2+Presenter.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 23/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import FruityKit

extension DeviceConfigurationViewV2 {
    
    class Presenter: ObservableObject {
        
        enum Action {
            
            case commit
            case setMode(Synapse2ModeBasic)
        }
        
        let device: Device
        let engine: Engine
        
        @Published var selectedMode: Synapse2ModeBasic = .wave
        @Published var synapseMode: Synapse2Handle.Mode? = .wave(direction: .right)
        
        init(device: Device, engine: Engine) {
            self.device = device
            self.engine = engine
            
            if let storedConfiguration = DeviceConfigurationV2.get(forDeviceWithShortName: device.shortName) {
                selectedMode = storedConfiguration.synapseMode.synapse2ModeBasic
                synapseMode = storedConfiguration.synapseMode
            }
        }
        
        func perform(_ action: Action) {
            switch action {
            case .commit:
                guard let razerDevice = device.razerDevice else {
                    assertionFailure("`razerDevice` should never be nil on a non-stub device driver.")
                    
                    return
                }
                
                guard case let Driver.v2(driver: handle) = razerDevice.driver else {
                    assertionFailure("Driver should be of Synapse2 type.")
                    
                    return
                }
                
                guard let mode = synapseMode else {
                    //  Nothing to write...
                    
                    return
                }
                
                _ = handle.write(mode: mode)
                
                engine.persistence.setMode(mode, forDeviceWithShortName: device.shortName)
                
            case .setMode(let mode):
                selectedMode = mode
                
                let white = FruityKit.Color(red: 255, green: 255, blue: 255)
                
                switch mode {
                case .wave:
                    synapseMode = .wave(direction: .right)
                case .spectrum:
                    synapseMode = .spectrum
                case .reactive:
                    synapseMode = .reactive(speed: 1, color: white)
                case .static:
                    synapseMode = .static(color: white)
                case .breath:
                    synapseMode = .breath(color: white)
                }
            }
        }
    }
}
