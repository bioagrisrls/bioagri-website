# bioagri-website
[![Build Status](https://travis-ci.com/nefele-org/nefele-desktop.svg?branch=master)](https://travis-ci.com/nefele-org/nefele-desktop)
[![Total alerts](https://img.shields.io/lgtm/alerts/g/nefele-org/nefele-desktop.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/nefele-org/nefele-desktop/alerts/)
[![Language grade: Java](https://img.shields.io/lgtm/grade/java/g/nefele-org/nefele-desktop.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/nefele-org/nefele-desktop/context:java)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](/LICENSE)

Bioagri Website



## Prerequisites
- Docker
- Docker Compose (provided by Docker Hub on Windows)
- NodeJS

### PostgreSQL
In order to install PostgreSQL, we provide a ```docker-compose.yml``` script file inside ```utils/postgres``` directory.  
Run with following command:
```shell script
$ cd utils/postgres
$ sudo docker-compose -d up
```

#### Load Database
After successful running, open your web browser e go to: http://localhost:5050  
Authenticate yourself with
```shell
Username: admin@web.unical.it
Password: admin
```

Setup a new server with these following properties:
```shell
Host: postgres
Username: admin
Password: admin
```

Create a new databased named ```bioagridb```, open Tools->QueryTool and paste all the content from ```utils/database/prefab.sql```


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

## Running
Open your web browser on http://localhost:8080 after successful build.

## License

Copyright (c) Bioagri S.r.l.s. All rights reserved.

Licensed under the [MIT](/LICENSE) license.

