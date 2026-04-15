# NIST TN 2365
## Understanding the Risk of Lithium Ion Battery Fires


These files lay out the data and methods used for this project. Results in
the paper (except for the Google News analysis) are derived from the analysis
documented in these files. For a detailed discussion of the results and an 
uncertainty analysis of those results see the paper at 
<https://doi.org/10.6028/NIST.TN.2365>.

Files in the main directory are R Markdown (`Rmd`) files or `.R` script 
files that contain a mix of markdown text and R code. There are a total
of 11 such files (including this `README.md` file) in the main directory.

The `csv` directory contains the actual data used in the analysis below.
The data in that directory are in the format of `.csv`, `.zip` or `.xlsx` 
files . There are 14 `.csv` files, two `.zip` files and two `.xlsx` files
for a total of 18 files.

The `rdata` directory contains `RData` files, which are the native save file
format for R. Those files contain a mix of the raw data (reformatted from the 
data in the `csv` directory) and analytical results. There are six `RData`
files that contain reformatted forms of the data in the `.csv` files 
(`CarFires.data.RData`, `cpsc.data.RData`, `nfirs.data.RData`,
`recapture.data.RData`, `stan.models.RData`, `vin.data.RData`), with the 
remaining 8 files being analytical results. There are a total of 14 files
in the `rdata` directory.

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
|maxLik      |1.5-2.1 |
|reticulate  |1.42.0  |
|ggtern      |3.5.0   |

The AI analysis in `CPSC.Rmd` uses Python 3.11.8 which in turn uses 
the following Python packages:

|Package     |Version   |
|:-----------|:---------|
|os          |\<built in\>|
|re          |\<built in\>|
|httpx       |  0.28.1  |
|openai      |  1.99.2  |

To run the AI analysis you will need access to a LLM API (via the OpenAI
API). The version used for this analysis is described in the associated 
paper, but may not be accessible to others.

Python and R are languages that are commonly used for scientific work, 
and are freely available from their respective organizations 
(<https://www.python.org> and <https://cran.r-project.org>). Packages are available 
through their respective package management ecosystems.

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
  (there should be 18 and 14 files respectively).
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
* Make sure the files in the `csv`directory are present (there should be
  18 present).
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
  (there should be 18 and 14 respectively).
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
* Make sure the files in the `csv`directory is present (there should be 18).
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
repopulate the `rdata` directory with the intermediate file(s) you deleted.

## NIST Software Disclaimer:

NIST-developed software is provided by NIST as a public service. 
You may use, copy, and distribute copies of the software in any 
medium, provided that you keep intact this entire notice. You may 
improve, modify, and create derivative works of the software or 
any portion of the software, and you may copy and distribute such 
modifications or works. Modified works should carry a notice 
stating that you changed the software and should note the date 
and nature of any such change. Please explicitly acknowledge 
the National Institute of Standards and Technology as the source 
of the software. 

NIST-developed software is expressly provided "AS IS." NIST MAKES 
NO WARRANTY OF ANY KIND, EXPRESS, IMPLIED, IN FACT, OR ARISING BY 
OPERATION OF LAW, INCLUDING, WITHOUT LIMITATION, THE IMPLIED 
WARRANTY OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, 
NON-INFRINGEMENT, AND DATA ACCURACY. NIST NEITHER REPRESENTS NOR 
WARRANTS THAT THE OPERATION OF THE SOFTWARE WILL BE UNINTERRUPTED 
OR ERROR-FREE, OR THAT ANY DEFECTS WILL BE CORRECTED. NIST DOES 
NOT WARRANT OR MAKE ANY REPRESENTATIONS REGARDING THE USE OF THE 
SOFTWARE OR THE RESULTS THEREOF, INCLUDING BUT NOT LIMITED TO THE 
CORRECTNESS, ACCURACY, RELIABILITY, OR USEFULNESS OF THE SOFTWARE.
You are solely responsible for determining the appropriateness of 
using and distributing the software and you assume all risks 
associated with its use, including but not limited to the risks 
and costs of program errors, compliance with applicable laws, 
damage to or loss of data, programs or equipment, and the 
unavailability or interruption of operation. This software is 
not intended to be used in any situation where a failure could 
cause risk of injury or damage to property. The software developed 
by NIST employees is not subject to copyright protection within 
the United States.

## Commercial Product Disclaimer:

Certain equipment, instruments, software, or materials are 
identified in this software publication in order to specify 
the experimental procedure adequately.  Such identification 
is not intended to imply recommendation or endorsement of any 
product or service by NIST, nor is it intended to imply that 
the materials or equipment identified are necessarily the best 
available for the purpose.
