
args <- commandArgs(trailingOnly = TRUE)

input_file <- args[1]

1:10

message(input_file)

message(getwd())

rmarkdown::render(input_file, output_dir = getwd(), intermediates_dir = getwd())
