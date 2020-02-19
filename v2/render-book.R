
args <- commandArgs(trailingOnly = TRUE)

input_dir <- args[1]
local_library <- args[2]

.libPaths(local_library)

dir.create("_bookdown_files/_main_cache/html", recursive = TRUE)

cache_dirs <- grep(args[-(1:2)], pattern = "_cache$", value = TRUE)
cache_files <- list.files(cache_dirs, pattern = "rdx|rdb|RData", recursive = TRUE, full.names = TRUE)
file.copy(from = cache_files, 
	to = "_bookdown_files/_main_cache/html/", 
	recursive = TRUE)

## the cache folders also contain a list of packages
pkgs <- list.files(cache_dirs, pattern = "__packages", recursive = TRUE, full.names = TRUE)
pkgs <- unique(do.call('rbind', lapply(pkgs, read.table, stringsAsFactors = FALSE))[,1])
write.table(pkgs, file = "_bookdown_files/_main_cache/html/__packages", 
	row.names = FALSE, col.names = FALSE, quote = FALSE)

sapply(list.files(input_dir, full.names = TRUE), file.copy, to = getwd(), recursive = TRUE)

bookdown::render_book("index.Rmd")