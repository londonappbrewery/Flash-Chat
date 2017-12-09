# Flash-Chat
Learn to make iOS Apps 📱 | Project Stub | (Swift 3.0/Xcode 8) - Flash Chat App

Download the starter project files as .zip and extract to your desktop. ^^

## Podfile Addition
```
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CLANG_WARN_DOCUMENTATION_COMMENTS'] = 'NO'
        end
    end
end
```

## SVProgressHUD WARNINGS
Clic on Pods in the project navigator
-> clic on SVProgressHUD in the target list
-->under deployment info/deployment target select 10.0 in the dropdown list
in this way all the warnings that appear in the build phase will be deleted

## Finished App
![Finished App](https://github.com/londonappbrewery/Images/blob/master/Flash%20Chat.gif)



Copyright 2016 London App Brewery
