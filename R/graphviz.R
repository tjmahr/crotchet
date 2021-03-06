#' Returns a path to a graphviz file included in the specified package.
#' @export
find_graphviz <- function(name, package, inst_dir_name = "extdata") {
  find_figure(name, ext = ".gv", package = package, inst_dir_name = inst_dir_name)
}

#' List all graphviz files available in the specified package
#' @importFrom tools file_path_sans_ext
#' @export
list_graphviz <- function(package, inst_dir_name = "extdata", strip_ext = TRUE) {
  extdata_dir <- system.file(inst_dir_name, package = package)
  gv_files <- list.files(extdata_dir, "*.gv", recursive = TRUE)
  if(strip_ext) gv_files <- tools::file_path_sans_ext(basename(gv_files))
  gv_files
}

#' Read the graphviz files in a package as knitr chunks.
#' @importFrom knitr read_chunk
#' @export
read_all_graphviz_chunks <- function(package) {
  chunk_names <- list_graphviz(package, strip_ext = TRUE)
  for (name in chunk_names) {
    chunk_path <- find_graphviz(name, package)
    read_chunk(chunk_path, labels = name)
  }
}
