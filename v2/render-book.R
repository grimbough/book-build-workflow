
args <- commandArgs(trailingOnly = TRUE)

input_dir <- args[1]
local_library <- args[2]

.libPaths(local_library)

## we add the local library to .Rprofile so the R sessions 
## launched by bookdown::render() can also find it
xfun::write_utf8(text = paste0(".libPaths('", local_library, "')"),
	con = file.path(Sys.getenv("HOME"), ".Rprofile") )

dir.create("_bookdown_files")
file.copy(args[-(1:2)], to = "_bookdown_files/", recursive = TRUE)

#dir.create("_bookdown_files/_main_files/figure-html", recursive = TRUE)
#fig_dirs <- grep(args[-(1:2)], pattern = "_files$", value = TRUE)
#fig_files <- list.files(fig_dirs, pattern = "png|jpg|svg", recursive = TRUE, full.names = TRUE)
#file.copy(from = fig_files, 
#	to = "_bookdown_files/_main_files/figure-html/", 
#	recursive = TRUE)

# dir.create("_bookdown_files/_main_cache/html", recursive = TRUE)
# cache_dirs <- grep(args[-(1:2)], pattern = "_cache$", value = TRUE)
# cache_files <- list.files(cache_dirs, pattern = "rdx|rdb|RData", recursive = TRUE, full.names = TRUE)
# file.copy(from = cache_files, 
# 	to = "_bookdown_files/_main_cache/html/", 
# 	recursive = TRUE)

# ## the cache folders also contain a list of packages
# pkgs <- list.files(cache_dirs, pattern = "__packages", recursive = TRUE, full.names = TRUE)
# pkgs <- unique(do.call('rbind', lapply(pkgs, read.table, stringsAsFactors = FALSE))[,1])
# write.table(pkgs, file = "_bookdown_files/_main_cache/html/__packages", 
# 	row.names = FALSE, col.names = FALSE, quote = FALSE)

invisible(
	sapply(list.files(input_dir, full.names = TRUE), file.copy, to = getwd(), recursive = TRUE)
)


bookdown::render_book("index.Rmd", new_session = TRUE)