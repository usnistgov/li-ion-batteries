# Li Ion Battery Fires

These files lay out the data and methods used for this project. Results in
the paper (except for the Google News analysis) are derived from the analysis
documented in these files.

Files in the main directory are R Markdown (`Rmd`) files that contain a 
mix of markdown text and R code.

The `csv` directory contains the actual data used in the analysis below.
The data in that directory are in the format of `.csv` files (with the 
exception of one file that isn't actually used). 

The `rdata` directory contains `RData` files, which are the native save file
format for R. Those files contain a mix of the raw data (reformatted from the 
data in the `csv` directory) and analytical results.

The scripts are R Markdown files, with the code in R. A number of packages
are used either to run the `Rmd` files or are used by the `Rmd` files to 
perform the analysis. These must be present for the scripts to run.

|Package     |Version |
|:-----------|:-------|
|bookdown    |0.43    |
|rmarkdown   |2.29    |
|knitr       |1.50    |
|tidyr       |1.3.1   |
|dplyr       |1.1.4   |
|stringr     |1.5.1   |
|magrittr    |2.0.3   |
|lubridate   |1.9.4   |
|ggplot2     |3.5.2   |
|openxlsx2   |1.16    |
|rstan       |2.32.7  |
|reticulate  |1.42.0  |
|ggtern      |3.5.0   |

In addition, the following packages are highly recommended if you intend to
run the scripts from the raw data.

|Package     |Version |
|:-----------|:-------|
|parallel    |4.5.0   |
|doParallel  |1.0.17  |

The AI analysis in `CPSC.Rmd` uses Python 3.11.8 which in turn uses 
the following Python packages:

|Package     |Version   |
|:-----------|:---------|
|os          |<built in>|
|re          |<built in>|
|httpx       |  0.28.1  |
|openai      |  1.99.2  |

After installation of R and the essential packages (and dependencies), there 
are two basic approaches that can be used duplicate the analysis, each with two
variants. First any of the R Markdown files can be processed individually using
the `rmarkdown` and `knitr` packages, or the entire collection of `Rmd` files 
can be run simultaneously using the `bookdown` package. Each approach has two 
alternatives. Either the the scripts can be run from the raw data files or the 
scripts can be run using the intermediate outputs already saved. Each of the 
four approaches to running this is described below.


## Complete Run from intermediate files

This is the simplest approach. 

* Download all the files from GitHub.
* Make sure the `csv` and `rdata` directories exist
* Make sure the files in the `csv` and `rdata` directories are present
* make sure there is no `_main.md` file in the base directory
* Run the following code in `R`

```
library(bookdown)
setwd("/path/to/directory/with/rmd_files/")
render_book("index.Rmd")
```

This will produce a `_main.html` file as its output.

## Complete Run from base csv files

Running from the base csv files means that all the intermediate files will be 
generated (and saved) by the scripts. Be warned: this will likely take 
several hours of running time.

* Download all the files from GitHub.
* Make sure the `csv` and `rdata` directories exist
* Make sure the files in the `csv`directory are present
* Delete all files from the `rdata` directory. Note that the directory itself 
must still be present for the scripts to run.
* make sure there is no `_main.md` file in the base directory
* Run the following code in `R`

```
library(bookdown)
setwd("/path/to/directory/with/rmd_files/")
render_book("index.Rmd")
```

This will repopulate the `rdata` directory with the intermediate files you
deleted above as well as producing a `_main.html` file as output.

## Run individual script file from intermediate files

* Download all the files from GitHub.
* Make sure the `csv` and `rdata` directories exist
* Make sure the files in the `csv` and `rdata` directories are present
* Run the following code in `R`

```
library(rmarkdown)
setwd("/path/to/directory/with/rmd_files/")
render("02.NFIRS.Rmd")
```

In the case of the last line, replace `02.NFIRS.Rmd` with the name of the 
individual script file you want to run. 

This will produce a `0x.[scriptname].html` file as its output.

## Run individual script file from base csv files

Again, running from the base csv files means that all the intermediate files 
will be generated (and saved) by the script. Running time will vary significant
based on the script file you run. `03.CPSC.Rmd` will likely take a very long 
time, while `05.FAA_Air.Rmd` and `06.Bess.Rmd` will run about as fast as they
would otherwise.

* Download all the files from GitHub.
* Make sure the `csv` and `rdata` directories exist
* Make sure the files in the `csv`directory is present
* Delete the relevant intermediate data file from the `rdata` directory. 
File to delete is listed in the following table. Note that the relevant 
`[script].data.RData` file must also be present for the script to run.

| Script | Delete | Keep |
|--------|--------|------|
| 01.Data.Rmd | - | - |
| 01a.Car Fires.Rmd | CarFires.RData, CarFires.stan.RData | CarFires.data.RData, stan.models.RData, vin.data.RData |
| 02.NFIRS.Rmd | NFIRS.RData | nfirs.data.RData |
| 03.CPSC.Rmd | cpsc.RData, cpsc.inc.RData | cpsc.data.RData |
| 04.Recapture.Rmd | recapture.RData | recapture.data.RData, cpsc.inc.RData, NFIRS.RData, stan.models.RData |
| 05.FAA_Air.Rmd | faa_air.RData | - |
| 06.BESS.Rmd | bess.RData | - |

* Run the following code in `R`

```
library(rmarkdown)
setwd("/path/to/directory/with/rmd_files/")
render("02.NFIRS.Rmd")
```

Again, replace `02.NFIRS.Rmd` with the name of the 
individual script file you want to run. 

This will produce a `0x.[scriptname].html` file as its output. It will also 
repopulate the `rdata` directory with the intermediate file you deleted.
