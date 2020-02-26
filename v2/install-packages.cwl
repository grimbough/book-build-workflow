#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

baseCommand: Rscript

requirements:
  ResourceRequirement:
    coresMin: 4

hints:
  DockerRequirement:
    dockerPull: bioconductor/bioconductor_docker:RELEASE_3_10
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
  rmd_chapters:
    type: Directory
    inputBinding:
      position: 3    

outputs:
  packages:
    type:
      type: array
      items: Directory
    outputBinding:
      glob: '*'

