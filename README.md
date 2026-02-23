# MinMIP Watchface - Garmin Fenix 7S Pro

A beautiful and minimalist watchface for Garmin Fenix 7S Pro, built with MonkeyC.

## Features

- **Minimalist Design**: Clean, modern interface optimized for AMOLED readability
- **Real-time Information**:
  - Current time with large display
  - Battery percentage / charge status
  - Temperature and weather conditions
  - Altitude (outdoor data)
  - Compass heading
  - Heart rate
  - Step count
- **Interactive**: Tap battery indicator to toggle between percentage and visual bar
- **Sensor Integration**: Low-rate magnetometer for heading, ActivityMonitor for health data
- **Performance Optimized**: MIP display optimization for Fenix 7S Pro

## Project Structure

```
MinMIP_WF/
├── source/
│   ├── App.mc                          # Main application entry point
│   ├── Services/
│   │   ├── SensorService.mc           # Magnetometer and sensor handling
│   │   └── WeatherService.mc          # Weather data integration
│   ├── UI/
│   │   ├── BatteryArc.mc              # Battery arc visualization
│   │   ├── Format.mc                  # Formatting utilities
│   │   ├── Layout.mc                  # Layout constants
│   │   └── Palette.mc                 # Color definitions
│   └── Views/
│       ├── InputDelegate.mc           # Touch input handling
│       └── WatchFaceView.mc           # Main watchface rendering
├── resources/
│   ├── drawables/                     # Icons and images
│   ├── layouts/                       # Layout definitions
│   └── strings/                       # Localized strings (ENG/ESP)
├── manifest.xml                       # Application manifest
├── monkey.jungle                      # Build configuration
├── build.ps1                          # Compile script
└── run-simulator.ps1                  # Run in simulator script
```

## Setup & Build

### Prerequisites
- Garmin ConnectIQ SDK 8.4.1 or later
- MonkeyC Compiler
- PowerShell 5.1+

### Building

**Compile only:**
```powershell
.\build.ps1
```

**Compile & run in simulator:**
```powershell
.\run-simulator.ps1
```

### Manual Compilation

```powershell
monkeyc -d fenix7spro -f monkey.jungle -o bin\MinMIP_WF.prg -y "C:\DevKeys\developer_key" -g
```

## Installation on Device

After successfully testing in the simulator:

1. Build the release version (without debug):
   ```powershell
   monkeyc -d fenix7spro -f monkey.jungle -o bin\MinMIP_WF.iq -e -y "C:\DevKeys\developer_key"
   ```

2. Load `bin/MinMIP_WF.iq` onto your device using Garmin ConnectIQ Manager

## Development

### Color Palette
- Primary Text: `#FFFFFF` (White)
- Secondary Text: `#EAEAEA` (Light Gray)
- Accent: `#FF8A2B` (Orange)
- Backgrounds: Custom gradient (top: `#1C2A24`, mid: `#000000`, bot: `#243832`)

### Layout Constants
- Screen: 260×260 px
- Battery hit zone: Bottom right area (tap to toggle display)

### UI Modules
- **BatteryArc**: Arc-based battery visualization
- **Format**: Text formatting utilities (time, cardinal directions)
- **Palette**: Centralized color management

## Recent Changes

- ✅ Fixed module structure (converted nested modules to static classes)
- ✅ Resolved type errors in MonkeyC compilation
- ✅ Optimized sensor initialization

## Known Issues

- Charging status is currently a stub (API pending confirmation)
- Weather data requires internet connectivity on device

## Contributing

Fork, make changes, and submit pull requests.

## License

MIT License - See LICENSE file for details

## Author

Pablo Sepulveda
