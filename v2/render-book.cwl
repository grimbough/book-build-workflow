#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

baseCommand: Rscript

hints:
  DockerRequirement:
    dockerPull: rocker/tidyverse

inputs:
  r_script:
    type: File
    inputBinding:
      position: 1
  rmd_chapters:
    type: Directory
    inputBinding:
      position: 2
  local_library:
    type: Directory
    inputBinding:
      position: 3
  cache_dirs:
    type:
      type: array
      items:
        type: array
        items: Directory
    inputBinding:
      position: 4

outputs:
  book_dir:
    type: Directory
    outputBinding:
      glob: "_book"
