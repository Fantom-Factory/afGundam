#Gundam v2.0.4
---
[![Written in: Fantom](http://img.shields.io/badge/written%20in-Fantom-lightgray.svg)](http://fantom.org/)
[![pod: v2.0.4](http://img.shields.io/badge/pod-v2.0.4-yellow.svg)](http://www.fantomfactory.org/pods/afGundam)
![Licence: MIT](http://img.shields.io/badge/licence-MIT-blue.svg)

## Overview

`Gundam` is a pure Fantom horizontally scrolling shoot'em'up that runs both from the desktop and in a browser!

![Gundam Screenshot](http://pods.fantomfactory.org/pods/afGundam/doc/screenshot.jpg)

Visit the [Alien-Factory Gundam Page](http://www.alienfactory.co.uk/gundam/) to find out more, or play [Gundam Online](http://www.alienfactory.co.uk/gundam/playonline) now!

## Install

Install `Gundam` with the Fantom Repository Manager ( [fanr](http://fantom.org/doc/docFanr/Tool.html#install) ):

    C:\> fanr install -r http://repo.status302.com/fanr/ afGundam

To use in a [Fantom](http://fantom.org/) project, add a dependency to `build.fan`:

    depends = ["sys 1.0", ..., "afGundam 2.0"]

## Documentation

Full API & fandocs are available on the [Fantom Pod Repository](http://pods.fantomfactory.org/pods/afGundam/).

## Quick Start

### Run from Desktop

Run `Gundam` from the command line:

    C:\> fan afGundam
    
    [info] [LoadingScreen]
    [info] [LoadingScreen] GUNDAM 2.0.4
    [info] [LoadingScreen] ============
    [info] [LoadingScreen]
    [info] [JavaVersion] Java Version OK : 1.6.0_45

### Run in Browser

Run `Gundam` from the command line with the `-ws` option to start the Gundam web server:

    C:\> fan afGundam -ws
    
    [info] [web] WispService started on port 8080
    
    Then point your browser at `http://localhost:8080/`.

