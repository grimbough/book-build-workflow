
#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)

input_file <- args[1]
local_library <- args[2]

.libPaths(local_library)

library(bookdown)
#preview_chapter(input = input_file, 
	#clean_envir = FALSE)
rmarkdown::render(input_file, 
	#output_dir = xfun::sans_ext(input_file),
	output_options = list(lib_dir = file.path(xfun::sans_ext(input_file), "libs")),
	run_pandoc = FALSE)
