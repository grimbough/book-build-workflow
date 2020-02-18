
args <- commandArgs(trailingOnly = TRUE)

local_library <- args[1]

.libPaths(local_library)

.libPaths()

install.packages('bookdown', lib = "/usr/local/lib/R/site-library/")