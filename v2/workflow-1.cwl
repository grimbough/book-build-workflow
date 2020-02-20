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
      - $(inputs.rmd_chapter)

inputs:
  r_script:
    type: File
    inputBinding:
      position: 1
  rmd_chapter:
    type: File
    inputBinding:
      position: 2
  local_library:
    type: Directory
    inputBinding:
      position: 3

stdout: '$(inputs.rmd_chapter.nameroot).out'

outputs:
  book_html:
    type: 
      type: array
      items: Directory
    outputBinding:
      glob: '$(inputs.rmd_chapter.nameroot)_*'
  std_out:
    type: stdout
