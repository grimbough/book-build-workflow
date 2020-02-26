#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

baseCommand: Rscript

hints:
  DockerRequirement:
    dockerPull: bioconductor/bioconductor_docker:RELEASE_3_10

requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.images_dir)
      - $(inputs.data_dir)
      - $(inputs.bibtex)

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
  images_dir:
    type: Directory
    inputBinding:
      position: 4
  data_dir:
    type: Directory
    inputBinding:
      position: 5
  bibtex:
    type: File
    inputBinding:
      position: 6
  cache_dirs:
    type:
      type: array
      items:
        type: array
        items: Directory
    inputBinding:
      position: 7


outputs:
  book_dir:
    type: Directory[]
    outputBinding:
      glob: "_book*"
