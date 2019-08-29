library(readr)
library(glue)
library(fs)
library(rmarkdown)

d <- read_csv("svg/ebs_links.csv")

# create/render modals by iterating over svg links in csv
for (i in 1:nrow(d)){
  # paths
  htm <- d$link[i]
  rmd <- path_ext_set(htm, "Rmd")
  
  # create Rmd, if doesn't exist
  if (!file.exists(rmd)) file.create(rmd)
  
  # render Rmd to html, if Rmd newer
  if (file_info(rmd)$modification_time > file_info(htm)$modification_time){
    render(rmd, html_document(self_contained=F, lib_dir = "modal_libs", mathjax = "local"))
  }
}

# render website, ie Rmds in root
render_site()

