HARtools
==========================
| CRAN version       | Travis build status   | Coverage |
| :-------------: |:-------------:|:-------------:|
| [![](http://www.r-pkg.org/badges/version/HARtools)](https://CRAN.R-project.org/package=HARtools) | [![Build Status](https://travis-ci.org/johndharrison/HARtools.svg?branch=master)](https://travis-ci.org/johndharrison/HARtools) | [![codecov](https://codecov.io/gh/johndharrison/HARtools/branch/master/graph/badge.svg)](https://codecov.io/gh/johndharrison/HARtools)|


##### *HTTP Archive (HAR) utility methods for easy manipulation and lookup*

### Introduction

HARtools provdes tools and utilities to interact with HTTP Archive (HAR) 
files. 

### Install

To install the current developement version of `HARtools` run:

```
devtools::install_github("johndharrison/HARtools")
```

### Getting started


#### Read from file

```
har <- readHAR(system.file(package = "HARtools", "exdata",     "inline-scripts-block.har"))

> har
--------HAR VERSION-------- 
HAR specification version: 1.1 
--------HAR CREATOR-------- 
Created by: Firebug 
version: 1.5X.0b8 
--------HAR BROWSER-------- 
Browser: Firefox 
version: 3.6b6pre 
--------HAR PAGES-------- 
Page id: page_21396 , Page title: Cuzillion 
Page id: page_20633 , Page title: Cuzillion 
--------HAR ENTRIES-------- 
Number of entries: 8 
REQUESTS: 
  -  http://stevesouders.com/cuzillion/?ex=10100&title=Inline+Scripts+Block 
  -  http://stevesouders.com/cuzillion/logo-32x32.gif 
  -  http://1.cuzillion.com/bin/resource.cgi?type=gif&sleep=1&n=1&t=1262443132 
  -  http://1.cuzillion.com/bin/resource.cgi?type=gif&sleep=1&n=3&t=1262443132 
  -  http://stevesouders.com/cuzillion/?c0=bi1hfff1_0_f&c1=bi1hfff1_0_f&c2=bb0hfff... 
  -  http://stevesouders.com/cuzillion/logo-32x32.gif 
  -  http://1.cuzillion.com/bin/resource.cgi?type=gif&sleep=1&n=1&t=1262445158 
  -  http://1.cuzillion.com/bin/resource.cgi?type=gif&sleep=1&n=2&t=1262445158 
```

#### Read from URL

```
har <- readHAR("http://www.janodvarko.cz/har/viewer/examples/google.com.har")

> har
--------HAR VERSION-------- 
HAR specification version: 1.1 
--------HAR CREATOR-------- 
Created by: Firebug 
version: 1.5X.0b8 
--------HAR BROWSER-------- 
Browser: Firefox 
version: 3.6b6pre 
--------HAR PAGES-------- 
Page id: page_62143 , Page title: Google 
--------HAR ENTRIES-------- 
Number of entries: 5 
REQUESTS: 
  -  http://www.google.cz/ 
  -  http://www.google.cz/intl/en_com/images/logo_plain.png 
  -  http://www.google.cz/extern_js/f/CgJjcxICY3orMAo4QUAdLCswDjgKLCswFjgULCswFzgE... 
  -  http://clients1.google.cz/generate_204 
  -  http://www.google.cz/images/nav_logo7.png 
```
