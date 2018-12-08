###### ------------------------------------------------------------ ###
###### ------------------------------------------------------------ ###
###### NAME: Set-up for Statistical Rethinking
###### DATE: December 2018-March 2019
###### Version: 1
###### ------------------------------------------------------------ ###
###### ------------------------------------------------------------ ###
###### NOTES ######
###### Following:
###### https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started

# Loading package
if(!require(rstan)) install.packages("rstan",repos = "http://cran.us.r-project.org", dependencies = TRUE)
library("rstan")

# Checking C++ toolchain (Run once)
pkgbuild::has_build_tools(debug = TRUE)

# Optimising RStan
dotR <- file.path(Sys.getenv("HOME"), ".R")
if (!file.exists(dotR)) dir.create(dotR)
M <- file.path(dotR, ifelse(.Platform$OS.type == "windows", "Makevars.win", "Makevars"))
if (!file.exists(M)) file.create(M)
cat("\nCXX14FLAGS=-O3 -march=native -mtune=native",
    if( grepl("^darwin", R.version$os)) "CXX14FLAGS += -arch x86_64 -ftemplate-depth-256" else 
      if (.Platform$OS.type == "windows") "CXX11FLAGS=-O3 -march=native -mtune=native" else
        "CXX14FLAGS += -fPIC",
    file = M, sep = "\n", append = TRUE)

# Taking things back to normal if there is suddently a problem
M <- file.path(Sys.getenv("HOME"), ".R", ifelse(.Platform$OS.type == "windows", "Makevars.win", "Makevars"))
file.edit(M)