##########~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~######################################
########## STEP BY STEP GUIDE TO CREATE AN R PACKAGE --------- #############
##########~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~######################################
#### some guidance can be found at these sites ###
## https://r-pkgs.org/man.html
## https://www.mjandrews.org/blog/how-to-make-an-R-package/
## https://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/
## https://tinyheero.github.io/jekyll/update/2015/07/26/making-your-first-R-package.html


library(devtools)
library(usethis)
library(roxygen2)
library(sinew)
library(knitr)



### STEP 1. WRITE CODE -------

### STEP 2. WRITE DOCUMENTATION INTO CODE -------
### add the header information to your function code file
### write a vignette as R markdown (.rmd) file
# usethis::use_vignette(name="move2ch")

### STEP 3. CREATE PACKAGE BACKBONE -------
devtools::create("move2ch")
cat("Package: move2ch\n", file = "DESCRIPTION")
cat("Version: 1.0.0\n", file = "DESCRIPTION", append = TRUE)
#cat("Authors@R: person("Steffen", "Oppel", "steffen.oppel@vogelwarte.ch", role = c("aut", "cre"), comment = c(ORCID = "0000-0002-8220-3789"))\n", file = "DESCRIPTION", append = TRUE)
cat("Description: This tool downloads tracking data from Movebank and then creates an encounter history to facilitate survival analysis.\n", file = "DESCRIPTION", append = TRUE)
cat("License: `use_mit_license()`\n", file = "DESCRIPTION", append = TRUE)
cat("Encoding: UTF-8\n", file = "DESCRIPTION", append = TRUE)


### manually amend the DESCRIPTION file in a text editor (this doesn't work with the cat command above)
# Authors@R:
#   person("Steffen", "Oppel", , "steffen.oppel@vogelwarte.ch", role = c("aut", "cre"),
#          comment = c(ORCID = "0000-0002-8220-3789")))


### STEP 4. MOVE THE R FUNCTION FILES INTO THE R FOLDER OF THE PACKAGE DIRECTORY -------


### STEP 5. CREATING THE DOCUMENTATION FOR THE PACKAGE -------
devtools::load_all(path="./move2ch")
makeOxygen(move2ch)
roxygen2::roxygenize(package.dir = "./move2ch")
devtools::document(pkg="./move2ch")

### creates a utility function for the pipe operator
### close this script and move it inside the created R package folder and also move the functions into the /R subfolder
## you need to run this function from inside the package OR MANUALLY ADD 'export("%>%")' to the NAMESPACE
usethis::use_pipe()
devtools::document()

### STEP 6. OPTIONAL - ADD DATA IF YOUR PACKAGE COMES WITH DATA -------
# kite.tracks <- fread("whateverdata.csv"))
# usethis::use_data(kite.tracks)

### STEP 7. OPTIONAL - CREATE THE README VIGNETTE FOR YOUR PACKAGE -------
knit(input="README.rmd", output = "README.md") #see ?knit for more options


### STEP 8. INSTALL THE PACKAGE LOCALLY ON YOUR COMPUTER -------
devtools::load_all()
devtools::install()

## you can now test whether it works:
library(move2ch)
move2ch(study_id=37350671,occasion="2 weeks",start_cut=ymd("2012-01-10"),end_cut=ymd("2023-01-10"))


### STEP 9. PUBLISH THE PACKAGE IN A GIT HUB REPO SO OTHERS CAN USE IT -------
## https://medium.com/@abertozz/turning-an-r-package-into-a-github-repo-aeaebacfe1c
use_git()



### STEP 10. DOWNLOAD, INSTALL, and TEST ON ANOTHER MACHINE-------
devtools::install_github("steffenoppel/move2ch")
library(move2ch)
move2ch(study_id=37350671,occasion="3 weeks",start_cut=ymd("2012-01-10"),end_cut=ymd("2023-01-10"))


