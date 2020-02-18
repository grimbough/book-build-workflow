#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

baseCommand: Rscript

hints:
  DockerRequirement:
    dockerPull: rocker/tidyverse
    dockerOutputDirectory: /usr/local/lib/R/site-library

inputs:
  r_script:
    type: File
    inputBinding:
      position: 1
  local_library:
    type: Directory
    inputBinding:
      position: 2

outputs:
  packages:
    type:
      type: array
      items: Directory
    outputBinding:
      glob: '*'

