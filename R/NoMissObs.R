RemoveMissingObervation<-function(data, output, var.list, global=TRUE, ...){
  NameOfData<-deparse(substitute(data))
  if(is.data.frame(data)){
    if(is.logical(global)){
      if(global){
        if(missing(output)){
          NewName<-paste0(NameOfData,"Redu")
        } else {
          NewName<-paste0(NameOfData,output)
        }
        message(paste("Name of dataset is:",NewName))
      }
  
      if(missing(var.list)){
        TempData<-na.omit(data)
      } else {
        TempData<-data[eval(parse(text=paste0("!is.na(data$",var.list,")",collapse = " & "))),])
      }
      message(paste(NameOfData,"is reduced from",nrow(data),"to",nrow(TempData)))

      if(global){
        assign(NewName,TempData,envi=.GlobalEnv)
        message(paste("You have a global dataset and name is:",NewName))
      } else {
        return(TempData)
      }
    } else {
      message(paste(NameOfData,"is not a data.frame")))
    }
  } else {
    message(paste(NameOfData,"is not a data.frame")))
  }
}
