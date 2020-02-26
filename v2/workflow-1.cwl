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
      - $(inputs.rmd_chapter)
      - $(inputs.images_dir)
      - $(inputs.data_dir)

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
  images_dir:
    type: Directory
    inputBinding:
      position: 4
  data_dir:
    type: Directory
    inputBinding:
      position: 5

stdout: '$(inputs.rmd_chapter.nameroot).out'
stderr: '$(inputs.rmd_chapter.nameroot).err'

outputs:
  book_html:
    type: 
      type: array
      items: Directory
    outputBinding:
      glob: '$(inputs.rmd_chapter.nameroot)_*'
  std_out:
    type: stdout
  std_err:
    type: stderr