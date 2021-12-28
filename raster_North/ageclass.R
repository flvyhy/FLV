for(y in seq(from=0,to=300,by=10)){
  inputfilefolder <- dirname(parent.frame(2)$ofile)
  year <- y
  setwd(paste(inputfilefolder,"/TreeNum/year",year,sep = ""))
  dir.create(paste(inputfilefolder,"/ageclass/year",year,"/",sep = ""))
  output <- paste(inputfilefolder,"/ageclass/year",year,"/",sep = "")
  library(raster)
  library(parallel)
  speccsv <- function(x){
    specnames <- read.table(file=paste(inputfilefolder,"/specname.txt",sep=""),sep="",na.strings = "1")
    library(raster)
    library(tcltk)
    require(readr)
    f <- function(start_time) {#time of begin
      start_time <- as.POSIXct(start_time)
      dt <- difftime(Sys.time(), start_time, units="secs")
      format(.POSIXct(dt,tz="GMT"), "%H:%M:%S")
    }
    specname <- specnames[x,1]
    sumraster <- raster()
    #calculate the sum of ages
    for(p in c(6:22))
    {
      if (is.na(specnames[x,p+1])){
        break
      }
      else if(p==6){
        sumraster <- raster(paste(specname,"_TreeNum_Age",specnames[x,p]+1,"_Age",specnames[x,p+1],"_",year,".asc",sep=''),values=T)
      }
      else{
        sumraster <-sumraster+raster(paste(specname,"_TreeNum_Age",specnames[x,p]+1,"_Age",specnames[x,p+1],"_",year,".asc",sep=''),values=T)
      }
    }
    writeRaster(sumraster,paste(output,specname,"_SumNum_",year,".asc",sep=''))
    age1 <- specnames[x,2]
    age2 <- specnames[x,3] 
    age3 <- specnames[x,4]
    age4 <- specnames[x,5]
    for(a in c(6:(age1-1))){
      if(a==6){
        rage1 <- raster(paste(specname,"_TreeNum_Age",specnames[x,a]+1,"_Age",specnames[x,a+1],"_",year,".asc",sep=''),values=T)
      }
      else{
        rage1 <- rage1+raster(paste(specname,"_TreeNum_Age",specnames[x,a]+1,"_Age",specnames[x,a+1],"_",year,".asc",sep=''),values=T)
      }
    }
    writeRaster(rage1,paste(output,specname,"_Age1_TreeNum_",year,".asc",sep=''),overwrite=TRUE)
    for(a in c(age1:(age2-1))){
      if(a==age1){
        rage2 <- raster(paste(specname,"_TreeNum_Age",specnames[x,a]+1,"_Age",specnames[x,a+1],"_",year,".asc",sep=''),values=T)
      }
      else{
        rage2 <- rage2+raster(paste(specname,"_TreeNum_Age",specnames[x,a]+1,"_Age",specnames[x,a+1],"_",year,".asc",sep=''),values=T)
      }
    }
    writeRaster(rage2,paste(output,specname,"_Age2_TreeNum_",year,".asc",sep=''),overwrite=TRUE)
    for(a in c(age2:(age3-1))){
      if(a==age2){
        rage3 <- raster(paste(specname,"_TreeNum_Age",specnames[x,a]+1,"_Age",specnames[x,a+1],"_",year,".asc",sep=''),values=T)
      }
      else{
        rage3 <- rage3+raster(paste(specname,"_TreeNum_Age",specnames[x,a]+1,"_Age",specnames[x,a+1],"_",year,".asc",sep=''),values=T)
      }
    }
    writeRaster(rage3,paste(output,specname,"_Age3_TreeNum_",year,".asc",sep=''),overwrite=TRUE)
    for(a in c(age3:(age4-1))){
      if(a==age3){
        rage4 <- raster(paste(specname,"_TreeNum_Age",specnames[x,a]+1,"_Age",specnames[x,a+1],"_",year,".asc",sep=''),values=T)
      }
      else{
        rage4 <- rage4+raster(paste(specname,"_TreeNum_Age",specnames[x,a]+1,"_Age",specnames[x,a+1],"_",year,".asc",sep=''),values=T)
      }
    }
    writeRaster(rage4,paste(output,specname,"_Age4_TreeNum_",year,".asc",sep=''),overwrite=TRUE)
    write.table(specname,file=paste(output,specname,".txt",sep=''),append=F,row.names = F,col.names = F,quote = F)
    print(specname)#name of species
    
  }
  cl <- makeCluster(13)
  clusterExport(cl,"year")
  clusterExport(cl,"output")
  parLapply(cl,c(1:13),speccsv)
  stopCluster(cl)
}