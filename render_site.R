library(readr)
library(glue)
library(fs)
library(rmarkdown)

# parameters
csv         <- "svg/ebs_links.csv"
redo_modals <- F

# read in links for svg
d <- read_csv(csv)

# create/render modals by iterating over svg links in csv
for (i in 1:nrow(d)){
  # paths
  htm <- d$link[i]
  rmd <- path_ext_set(htm, "Rmd")
  
  # create Rmd, if doesn't exist
  if (!file.exists(rmd)) file.create(rmd)
  
  # render Rmd to html, if Rmd newer or redoing
  rmd_newer <- file_info(rmd)$modification_time > file_info(htm)$modification_time
  if (rmd_newer | redo_modals){
    render(rmd, html_document(self_contained=F, lib_dir = "modal_libs", mathjax = NULL))
  }
}

# render website, ie Rmds in root
render_site()

