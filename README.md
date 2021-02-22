# bioagri-website
[![Build Status](https://travis-ci.com/nefele-org/nefele-desktop.svg?branch=master)](https://travis-ci.com/nefele-org/nefele-desktop)
[![Total alerts](https://img.shields.io/lgtm/alerts/g/nefele-org/nefele-desktop.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/nefele-org/nefele-desktop/alerts/)
[![Language grade: Java](https://img.shields.io/lgtm/grade/java/g/nefele-org/nefele-desktop.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/nefele-org/nefele-desktop/context:java)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](/LICENSE)

Bioagri Website


## Building from sources
Clone sources from this repository:
```shell
$ git clone --depth=1 https://github.com/bioagrisrls/bioagri-website
```
## Prerequisites

- Docker
- Docker Compose (provided by Docker Desktop on Windows)
- NodeJS
- PostgreSQL

## Docker / Docker Compose
You can download Docker from [Docker Website](https://www.docker.com/get-started)

### NodeJS
In order to run building you need to install NodeJS dependencies, so open your project directory and execute the following command:
```shell
$ npm install
```

### PostgreSQL
In order to install PostgreSQL, we provide a ```docker-compose.yml``` script file inside ```utils/postgres``` directory.  
Run it with following command:
```shell script
$ cd utils/postgres
$ sudo docker-compose -d up
```

#### 1. Open PgAdmin4
After successful running, open your web browser e go to: http://localhost:5050  
Authenticate yourself with:
```shell
Username: admin@web.unical.it
Password: admin
```

#### 2. Setup a new Server
Setup a new server with these following properties:
```shell
Host: postgres
Username: admin
Password: admin
```

#### 3. Create and restore database
Create a new databased named ```bioagridb```, open *Tools->QueryTool* from the top menu and paste all the content from ```utils/database/prefab.sql```



## Build

To run BioagriShop, execute the following command:
```shell
$ ./gradlew :front-end:run --console=rich
```

**NOTE:** Building from sources requires **JDK 15.0.x**, you can download directly and unzip it from [OpenJDK Archive](https://jdk.java.net/archive/):
* [Windows](https://download.java.net/java/GA/jdk15.0.1/51f4f36ad4ef43e39d0dfdbaf6549e32/9/GPL/openjdk-15.0.1_windows-x64_bin.zip)
* [Mac](https://download.java.net/java/GA/jdk15.0.1/51f4f36ad4ef43e39d0dfdbaf6549e32/9/GPL/openjdk-15.0.1_osx-x64_bin.tar.gz)
* [Linux](https://download.java.net/java/GA/jdk15.0.1/51f4f36ad4ef43e39d0dfdbaf6549e32/9/GPL/openjdk-15.0.1_linux-x64_bin.tar.gzhttps://download.java.net/java/GA/jdk15/779bf45e88a44cbd9ea6621d33e33db1/36/GPL/openjdk-15_linux-x64_bin.tar.gz)

You need to set JAVA_HOME environment variable to point to your Java 15 directory, before running Gradle Wrapper.
```shell
export JAVA_HOME=/path_to_jdk_15
```

## Run
Open your web browser on http://localhost:8080 after successful build.

## License

Copyright (c) Bioagri S.r.l.s. All rights reserved.

Licensed under the [MIT](/LICENSE) license.

