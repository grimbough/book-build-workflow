#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

requirements:
  ScatterFeatureRequirement: {}

inputs:
  r_script: File
  chapters: File[]
  local_library: Directory

outputs:
  cache_dirs:
    type:
      type: array
      items:
        type: array
        items: Directory
    outputSource: compile/book_html

steps:
  compile:
    run: workflow-1.cwl
    scatter: rmd_chapter
    in:
      r_script: r_script
      rmd_chapter: chapters
      local_library: local_library
    out: [book_html]