# MemoClub 

`https://github.com/Jnpk1/Csc4360-Project-1.git`

link to website: `https://github.com/Jnpk1/Csc4360-Project-1`

## Goal of this project

Developed as a school project. The goal was to create an app that has multiple message rooms. We developed our app for Android/Webapp (Chrome). 


## Contributors / Authors:

* Nathan Larkin
* Drew Hartman
* James Park

## How to run the App:

1. Have all requirements downloaded
2. copy dependencies in `pubspec.yaml` file.
3. In CLI, type`flutter pub get` to install required plugins that were listed in the new `pubspec.yaml file`
4. To run android, in CLI type `flutter run`
5. To run web version instead. In CLI type `flutter run -d chrome --web-hostname localhost --web-port 8887`

## Build ID: 

`teamjnd.memoclub`

## Requirements:

* flutter 2.0+ is downloaded and installed
* files that were edited within `android/app/scr/main/res/  (necessary for splash screen)
* update contents in `android/app/src/AndroidManifest.xml`
* have all files in `/lib` downloaded
* Android SDK >= 21
* compatible on Android and Web (Chrome OS)

## Web app specific requirements:

* download and copy the contents within the `/web/` folder. The most important are the contents of the `index.html`file.


## Video Examples.

* [Splash Screen, Login, Registration](https://youtu.be/trdU3mPxiNU)
* [Socials, Profile, and Drawer](https://youtu.be/voPbMGEkBeU)
* [YouTube Video App Demonstration](https://www.youtube.com/watch?v=BA7VXg5wNgA)
* [Live demo of chatroom functionality](https://www.youtube.com/watch?v=_0hg9_O74EE)

## Areas of Improvement

The organization and design principles could use some improvement. We could have reduced duplicated code by reusing a widget class for the buttons throughout the app. Another area of improvement would be to limit where we access the Member model. We use `Provider.of<Member>(context)` to access it, so limiting the areas we call for this value would lead to the app rebuilding a smaller portion of the widget tree, thus improving performance. 

## Troubleshooting issues

* Clone the entire repository instead of copying certain files
* try `flutter clean` then `flutter pub get`
* install the plugins by doing `flutter get <addon>`, this was how I installed my addons. So it could have changed some config code somewhere in the project that I was unaware of.
* Web app issue, make sure you are using local host 8887 as this is the only client id authorized.

## Image of the way the Messages are stored in Firestore

[Imgur](https://i.imgur.com/gYHvjL4.png)
