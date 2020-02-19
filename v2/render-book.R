
args <- commandArgs(trailingOnly = TRUE)

input_dir <- args[1]
local_library <- args[2]

.libPaths(local_library)

dir.create("_book")

sapply(args[-(1:2)], file.copy, to = "_book", recursive = TRUE)

sapply(list.files(input_dir, full.names = TRUE), file.copy, to = getwd(), recursive = TRUE)

bookdown::render_book("index.Rmd")