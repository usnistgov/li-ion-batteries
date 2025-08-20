load.data <- function(final=NULL, data=NULL, dir){
  # Either load the completed data (in `final`)
  # or the relevant base data (in `data`).
  ff <- list.files(dir) %>% grep("RData", ., ignore.case=T, value=T)

  if(all(tolower(final) %in% tolower(ff))){
    files <- final
  } else if(all(tolower(data) %in% tolower(ff))){
    files <- data
  } else {
    return(1)
  }
  for(i in tolower(files)){
    i %>% match(tolower(ff)) %>% { ff[.] } %>% paste0(dir, .) %>% load(envir=.GlobalEnv)
  }
  return(0)
}