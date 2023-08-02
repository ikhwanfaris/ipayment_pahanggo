# flutterbase

Firebase CLI 3.3.10

# Quicklinks

* Generate `models` json serializeable
    * https://docs.flutter.dev/development/data-and-backend/json#running-the-code-generation-utility
    * `flutter pub run build_runner build --delete-conflicting-outputs`


# Troubleshoot

* [iOS] enforce target iOS 13
```
post_install do |installer|
  ...
  installer.generated_projects.each do |project|
      project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
          end
      end
  end
  ...
end
```
