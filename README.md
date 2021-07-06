# MemoClub 

## Goal of this project

* -------


## Contributors:

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

The organization and design principles in this project need improvement. I wasn't able to address these design issues because of the insane time crunch. To improve the program I would probably implement a `Multiprovider` and/or `FutureBuilder`, and the value that would change from my custom user model to the `Firebase.instance.currentUser`. I would possibly implement a more solid MVC design model and create toJson and fromJson methods to serialize communication between Firebase and the custom Class objects that represent the users/messages. I would also change the floating action button test to be based off a `Query` of the current user and see if they have the `userRole: admin`. This would allow for multiple admins to exist, and allow users to change roles easily.

## Troubleshooting issues

* Clone the entire repository instead of copying certain files
* try `flutter clean` then `flutter pub get`
* install the plugins by doing `flutter get <addon>`, this was how I installed my addons. So it could have changed some config code somewhere in the project that I was unaware of.
* Web app issue, make sure you are using local host 8887 as this is the only client id authorized.

## Image of the way the Messages are stored in Firestore

[Imgur](https://i.imgur.com/gYHvjL4.png)

## Authors

Nathan Larkin

James Park

Drew Hartman
