
#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)

input_file <- args[1]
local_library <- args[2]

.libPaths(local_library)

library(bookdown)

## turn on caching for everything
lines <- xfun::read_utf8(input_file)
yaml_end <- which(grepl(pattern = "---", x = lines))[2]
lines[yaml_end] <- 
"---
```{r, cache-on}
knitr::opts_chunk$set(cache = TRUE)
```
"
xfun::write_utf8(lines, con = input_file)


rmarkdown::render(input_file, 
	output_options = list(lib_dir = file.path(xfun::sans_ext(input_file), "libs")),
	run_pandoc = FALSE)
