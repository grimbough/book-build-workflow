#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

requirements:
  ScatterFeatureRequirement: {}

inputs:
  r_script_1: File
  r_script_2: File
  chapters: File[]
  chapters_dir: Directory
  local_library: Directory

outputs:
  book_dir:
    type: Directory
    outputSource: compile_book/book_dir

steps:

  render_chapters:
    run: workflow-1.cwl
    scatter: rmd_chapter
    in:
      r_script: r_script_1
      rmd_chapter: chapters
      local_library: local_library
    out: [book_html]

  compile_book:
    run: render-book.cwl
    in:
      r_script: r_script_2
      rmd_chapters: chapters_dir
      local_library: local_library
      cache_dirs: render_chapters/book_html
    out: [book_dir]