#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

baseCommand: Rscript

hints:
  DockerRequirement:
    dockerPull: rocker/tidyverse

requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.rmd_file)

inputs:
  r_script:
    type: File
    inputBinding:
      position: 1
  rmd_file:
    type: File
    inputBinding:
      position: 2

outputs:
  example_out:
    type: File
    outputBinding:
      glob: 'rmd1.html'
  cache_directory:
    type: 
      type: array
      items: Directory
    outputBinding:
      glob: 'rmd1_*'
