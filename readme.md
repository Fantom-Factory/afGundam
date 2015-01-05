## Overview 

`Gundam` is a horizontally scrolling shoot'em'up that runs on a desktop and in a browser!

## Install 

Install `Gundam` with the Fantom Repository Manager ( [fanr](http://fantom.org/doc/docFanr/Tool.html#install) ):

    C:\> fanr install -r http://repo.status302.com/fanr/ afGundam

To use in a [Fantom](http://fantom.org/) project, add a dependency to `build.fan`:

    depends = ["sys 1.0", ..., "afGundam 2.0"]

## Documentation 

Full API & fandocs are available on the [Status302 repository](http://repo.status302.com/doc/afGundam/).

## Quick Start 

### Run from Desktop 

1). Run `Gundam` from the command line:

```
C:\> fan afGundam

[info] [LoadingScreen]
[info] [LoadingScreen] GUNDAM 2.0.3
[info] [LoadingScreen] ============
[info] [LoadingScreen]
[info] [JavaVersion] Java Version OK : 1.6.0_45
```

### Run in Browser 

1). Run `Gundam` from the command line with the `-ws` option to start a web server:

```
C:\> fan afGundam -ws

[info] [web] WispService started on port 8080
```

Then point your browser at [http://localhost:8080/](http://localhost:8080/).

