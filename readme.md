#Gundam v2.1.2
---
[![Written in: Fantom](http://img.shields.io/badge/written%20in-Fantom-lightgray.svg)](http://fantom.org/)
[![pod: v2.1.2](http://img.shields.io/badge/pod-v2.1.2-yellow.svg)](http://www.fantomfactory.org/pods/afGundam)
![Licence: MIT](http://img.shields.io/badge/licence-MIT-blue.svg)

## Overview

Gundam is a horizontally scrolling shoot'em'up written in pure Fantom that runs on both the desktop and in a browser!

![Gundam Screenshot](http://pods.fantomfactory.org/pods/afGundam/doc/screenshot.jpg)

Visit [http://gundam.fantomfactory.org/](http://gundam.fantomfactory.org/) to play Gundam online!

Or [download Gundam](https://bitbucket.org/AlienFactory/afgundam/downloads) to play the desktop version.

See [Gundam on Alien-Factory](http://www.alienfactory.co.uk/gundam/) for game history and details.

## Install

Install `Gundam` with the Fantom Repository Manager ( [fanr](http://fantom.org/doc/docFanr/Tool.html#install) ):

    C:\> fanr install -r http://pods.fantomfactory.org/fanr/ afGundam

To use in a [Fantom](http://fantom.org/) project, add a dependency to `build.fan`:

    depends = ["sys 1.0", ..., "afGundam 2.1"]

## Documentation

Full API & fandocs are available on the [Fantom Pod Repository](http://pods.fantomfactory.org/pods/afGundam/).

## Gundam: Standalone

Gundam has been packaged into a standalone `.zip` file which does not require Fantom to be installed on a machine. (Though `java` must be available from the command line.)

To play, simply download from the [Gundam Downloads Page](https://bitbucket.org/AlienFactory/afgundam/downloads), unzip, and run the bundled script.

## Gundam: Pod Library

Gundam may also be installed into your existing Fantom environment by running the following:

    C:\> fanr install -r http://eggbox.fantomfactory.org/fanr/ afGundam

Note that Gundam is packaged with a web server, so it may either be started as a desktop app, or as a web server so you can play it in a browser!

### Desktop Version

To launch a desktop version of `Gundam` from the command line:

    C:\> fan afGundam
    
    [info] [LoadingScreen]
    [info] [LoadingScreen] GUNDAM 2.1.2
    [info] [LoadingScreen] ============
    [info] [LoadingScreen]
    [info] [JavaVersion] Java Version OK : 1.6.0_45

### Run in Browser

To start a webserver that serves up Gundam by using the `-ws` option:

    C:\> fan afGundam -ws
    
    [info] [web] WispService started on port 8080

Then point your browser at [http://localhost:8080/](http://localhost:8080/).

