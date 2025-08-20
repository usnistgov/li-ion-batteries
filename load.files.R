load.data <- function(final=NULL, data=NULL, dir){
  # Either load the completed data (in `final`)
  # or the relevant base data (in `data`).
  files <- final
  ff <- list.files(dir) %>% grep("RData", ., ignore.case=T, value=T)
  if(! all(tolower(files) %in% tolower(ff))) files <- data
  for(i in tolower(files)){
    i %>% match(tolower(ff)) %>% { ff[.] } %>% paste0(dir, .) %>% load(envir=.GlobalEnv)
  }
}