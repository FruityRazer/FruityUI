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
            case dismissError
            case setMode(Synapse2ModeBasic)
        }
        
        let device: Device
        let engine: Engine
        
        @Published var selectedMode: Synapse2ModeBasic = .wave
        @Published var synapseMode: Synapse2Handle.Mode? = .wave(speed: .default, direction: .right)
        
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
        
        var availableModes: [Synapse2ModeBasic] {
            guard case let Driver.v2(driver: handle) = device.razerDevice!.driver else {
                return []
            }
            
            return handle.supportedModes.map(Synapse2ModeBasic.init)
        }
        
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
                
                if razerDevice.connected {
                    guard handle.write(mode: mode) else {
                        error = "An error has occurred while setting the selected mode.\n\nMaybe this mode isn't supported by your device?"
                        
                        return
                    }
                }
                
                engine.persistence.setMode(mode, forDeviceWithShortName: device.shortName)
                
            case .dismissError:
                error = nil
                
            case .setMode(let mode):
                selectedMode = mode
                
                let white = FruityKit.Color(red: 255, green: 255, blue: 255)
                
                switch mode {
                case .breath:
                    synapseMode = .breath(color: white)
                case .reactive:
                    synapseMode = .reactive(speed: .default, color: white)
                case .spectrum:
                    synapseMode = .spectrum
                case .starlight:
                    synapseMode = .starlight(speed: .default, color1: white, color2: white)
                case .static:
                    synapseMode = .static(color: white)
                case .wave:
                    synapseMode = .wave(speed: .default, direction: .right)
                }
            }
        }
    }
}

extension DeviceConfigurationViewV2.Synapse2ModeBasic {
    
    init(basicMode: Synapse2Handle.BasicMode) {
        switch basicMode {
        case .breath:
            self = .breath
        case .reactive:
            self = .reactive
        case .spectrum:
            self = .spectrum
        case .starlight:
            self = .starlight
        case .static:
            self = .static
        case .wave:
            self = .wave
        }
    }
}
