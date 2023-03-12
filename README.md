## Project Structure

```
.
├── Weather-app
│   │   ├── App             # cotnains `AppDelegate` and `SceneDelegate`
│   │   ├── Models   
│   │   ├── Scenes          # contains all app Scenes
│   │   │   └── ${Module}   # contains concrete module, its structure is described in Layered architecture 
│   │   ├──  Services       # contains network and  storage services 
│   │   ├── Library         # contains Helper/Extensions files
│   │   │   └── Extension 
│   │   ├── Assets       # contains Assets and font 
│   │   ├──  Unit-Tests     
└── 
```

### Architecture
The project uses the **MVVM** design Pattern.
--- 
### Layered architecture

Each module is divided by layers:

```
├── Service
├── ViewModel
├── View
│   ├── Cell
│   └── Layout
```

### Dependencies
- **Kingfisher**
- **Alamofire**
- **SVProgressHUD**

### License

MIT
