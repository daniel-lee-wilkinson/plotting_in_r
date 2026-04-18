local({

  # the renv version to be used
  renv_version <- "1.0.7"

  # the project root directory
  project <- getwd()

  # avoid recursion issues with R CMD check
  checking <- nzchar(Sys.getenv("_R_CHECK_PACKAGE_NAME_", unset = ""))
  if (checking) {
    return(invisible(TRUE))
  }

  # helper to download and source renv bootstrap
  bootstrap <- function(version, library) {
    # attempt to download renv bootstrap
    url <- sprintf(
      "https://raw.githubusercontent.com/rstudio/renv/v%s/inst/resources/activate.R",
      version
    )
    # download to a temp file
    tmpfile <- tempfile()
    on.exit(unlink(tmpfile), add = TRUE)
    tryCatch(
      utils::download.file(url = url, destfile = tmpfile, quiet = TRUE),
      warning = function(e) stop("failed to download renv bootstrap script")
    )
    # source it
    source(tmpfile, local = FALSE)
  }

  # locate the renv autoloader
  autoloader <- file.path(project, "renv", "activate.R")

  # check if renv is available
  renv_available <- tryCatch({
    if (requireNamespace("renv", quietly = TRUE)) {
      installed_version <- utils::packageVersion("renv")
      if (installed_version >= renv_version) {
        TRUE
      } else {
        FALSE
      }
    } else {
      FALSE
    }
  }, error = function(e) FALSE)

  if (!renv_available) {
    # install renv if not available
    message(sprintf(
      "* Project requires renv %s but it is not installed; attempting to install.",
      renv_version
    ))
    tryCatch(
      utils::install.packages("renv", repos = "https://cloud.r-project.org"),
      warning = function(e) {
        message("* Failed to install renv automatically. Please run:")
        message("    install.packages(\"renv\")")
        message("  and then restart R to load the project environment.")
        return(invisible(FALSE))
      }
    )
  }

  # activate the renv environment for this project
  if (requireNamespace("renv", quietly = TRUE)) {
    renv::activate(project = project)
  }

})
