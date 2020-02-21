
args <- commandArgs(trailingOnly = TRUE)

local_library <- args[1]
input_dir <- args[2]

scrapeDependencies <- function(dir) {
  all.rmds <- list.files(dir, recursive=TRUE, full.names=TRUE, 
  	pattern="\\.rmd$", ignore.case = TRUE)
  collated <- character(0)
  
  for (i in seq_along(all.rmds)) {
    txt <- readLines(all.rmds[i], warn = FALSE)
    collated <- c(collated, 
                  .extract_pkgname("library\\(([^\\)]+)\\)", txt),
                  .extract_pkgname("require\\(([^\\)]+)\\)", txt),
                  .extract_pkgname("([^\\( -,=+/:`]+)::", txt))
  }
  
  collated <- unique(collated)
  sort(union(collated, c("BiocStyle", "bookdown")))
}

.extract_pkgname <- function(pattern, txt) {
  keep <- grep(pattern, txt)
  matching <- regmatches(txt, regexpr(pattern, txt))
  sub(pattern, "\\1", matching) 
}

.libPaths(local_library)

pkgsNeeded <- scrapeDependencies(input_dir) 
pkgsAvailable <- installed.packages()[, "Package"]
pkgsToInstall <- setdiff(pkgsNeeded, pkgsAvailable)

if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install(pkgsToInstall, lib = "/usr/local/lib/R/site-library/",
	ask = FALSE, update = TRUE)