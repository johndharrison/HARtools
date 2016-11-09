HARtools
==========================
| CRAN version       | Travis build status   | Coverage |
| :-------------: |:-------------:|:-------------:|
|  | [![Build Status](https://travis-ci.org/johndharrison/HARtools.svg?branch=master)](https://travis-ci.org/johndharrison/HARtools) | [![codecov](https://codecov.io/gh/johndharrison/HARtools/branch/master/graph/badge.svg)](https://codecov.io/gh/johndharrison/HARtools)|


##### *HAR utility functions for easy parsing/writing and manipulation in R*

### Introduction

HARtools provdes tools and utilities to interact with HTTP Archive (HAR) 
files in R. 

### Install

To install the current developement version of `HARtools` run:

```
devtools::install_github("johndharrison/HARtools")
```

### Getting started


#### Read from file

```
library(HARtools)
exampleHAR <- 
  system.file(package = "HARtools", "exdata", "inline-scripts-block.har")
har <- readHAR(exampleHAR)
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
  Page: page_20633 
Number of entries: 4 
-  http://stevesouders.com/cuzillion/?c0=bi1hfff1_0_f&c1=bi1hfff1_0_f&c2=bb0... 
-  http://stevesouders.com/cuzillion/logo-32x32.gif 
-  http://1.cuzillion.com/bin/resource.cgi?type=gif&sleep=1&n=1&t=1262445158 
-  http://1.cuzillion.com/bin/resource.cgi?type=gif&sleep=1&n=2&t=1262445158 
Page: page_21396 
Number of entries: 4 
-  http://stevesouders.com/cuzillion/?ex=10100&title=Inline+Scripts+Block 
-  http://stevesouders.com/cuzillion/logo-32x32.gif 
-  http://1.cuzillion.com/bin/resource.cgi?type=gif&sleep=1&n=1&t=1262443132 
-  http://1.cuzillion.com/bin/resource.cgi?type=gif&sleep=1&n=3&t=1262443132   
```

#### Read from URL

```
urlHAR <- "http://www.janodvarko.cz/har/viewer/examples/google.com.har"
har <- readHAR(urlHAR)
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
  Page: page_62143 
Number of entries: 5 
-  http://www.google.cz/ 
-  http://www.google.cz/intl/en_com/images/logo_plain.png 
-  http://www.google.cz/extern_js/f/CgJjcxICY3orMAo4QUAdLCswDjgKLCswFjgULCsw... 
-  http://clients1.google.cz/generate_204 
-  http://www.google.cz/images/nav_logo7.png 
```

#### View the HAR

`HARtools` includes a HARviewer function which utilises the 
[PerfCascade](https://github.com/micmro/PerfCascade) JavaScript library to 
produce an interactive waterfall chart of the HAR data:

```
har <- readHAR(system.file(package = "HARtools", "exdata",
                           "r-project.org.161028_W2_11MA.har"))
hv <- HARviewer(har)
# view in R
hv

# save and view
tFile <- tempfile(fileext = ".html")
htmlwidgets::saveWidget(hv,file = tFile)
browseURL(tFile)

```

![alt tag](https://raw.githubusercontent.com/johndharrison/HARtools/master/inst/misc/rprojectHAR.png)

The resulting output of HARviewer can be interacted with [here](http://rpubs.com/johndharrison/rprojectHAR).

#### Embed in a Shiny app

```
library(shiny)
if(interactive()){
  library(HARtools)
  har <- readHAR(system.file(package = "HARtools", "exdata",
                             "r-project.org.161028_W2_11MA.har"))
  hv <- HARviewer(har)
  
  app <- shinyApp(
    ui = fluidPage(
      HARviewerOutput("myHAR")
    ),
    server = function(input, output) {
      output$myHAR <- renderHARviewer(hv)
    }
  )  
  runApp(app)
}
```
