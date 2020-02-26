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
  images_dir: Directory
  data_dir: Directory
  local_library: Directory
  bibtex: File

outputs:
  book_dir:
    type: Directory[]
    outputSource: compile_book/book_dir
  chapter_std_out:
    type: File[]
    outputSource: render_chapters/std_out
  chapter_std_err:
    type: File[]
    outputSource: render_chapters/std_err

steps:

  render_chapters:
    run: workflow-1.cwl
    scatter: rmd_chapter
    in:
      r_script: r_script_1
      rmd_chapter: chapters
      images_dir: images_dir
      data_dir: data_dir
      local_library: local_library
    out: [book_html, std_out, std_err]

  compile_book:
    run: render-book.cwl
    in:
      r_script: r_script_2
      rmd_chapters: chapters_dir
      local_library: local_library
      cache_dirs: render_chapters/book_html
      images_dir: images_dir
      data_dir: data_dir
      bibtex: bibtex
    out: [book_dir]