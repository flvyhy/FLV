library(raster)
require(readr)
mosaicfilefolder <- dirname(parent.frame(2)$ofile)
if (dir.exists(paste(mosaicfilefolder,"/mask/",sep = ""))==0){
  dir.create(paste(mosaicfilefolder,"/mask/",sep = ""))
}
#need input
mosaic1 <- "Output1"
mosaic2 <- "Output2"
e <- extent(244391.272,584381.536,4496753.107,4836743.371)

for(year in seq(from=0,to=300,by=10)){
  specnames <- read.table(file=paste(mosaicfilefolder,"/specname.txt",sep=""),sep="",na.strings = "1")
  if (dir.exists(paste(mosaicfilefolder,"/mask/year",year,"/",sep = ""))==0){
  dir.create(paste(mosaicfilefolder,"/mask/year",year,"/",sep = ""))
  }
  output <- paste(mosaicfilefolder,"/mask/year",year,"/",sep = "")
  agenums <- data.frame(row.names = c(1:4))
  # for(age in c(1:4))
  # {
  #   write.table(paste("year",year,sep=""),file=paste(output,"readme_Age_",age,"_Year_",year,".txt",sep=''),append=F,row.names = F,col.names = F,quote = F)
  # }
  for(x in c(1:13))
  {
    specname <- specnames[x,1]
    agenum <- c()
    for(age in c(1:4))
    {
      ra <- raster(paste(mosaicfilefolder,"/",mosaic1,"/ageclass/","year",year,"/",specname,"_Age",age,
                        "_TreeNum_",year,".asc",sep=''))
      rb <- raster(paste(mosaicfilefolder,"/",mosaic2,"/ageclass/","year",year,"/",specname,"_Age",age,
                         "_TreeNum_",year,".asc",sep=''))
      r <- mosaic(ra,rb,fun=max,tolerance = 0.155)
      r[is.na(r)] <- 0
      a <- as.matrix(r)
      suma <- sum(a)
      maxa <- max(a)
      rextend <- r/maxa
      re <- extend(rextend,e,value=0)
      writeRaster(re,filename = paste(output,specname,
                                      "_mask_Age_",age,".tif",sep = ""),overwrite=TRUE)
      agenum <- c(agenum,round(suma/450))
    }
    agenums <- data.frame(agenums,agenum)
  }
  speagenums <- data.frame(specnames[,1],t(agenums))
  write_csv(speagenums,
            paste(output,"inputfile.csv"),col_names = F)
}
