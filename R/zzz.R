datacache <- new.env(hash=TRUE, parent=emptyenv())

RXprimeview <- function() showQCData("RXprimeview", datacache)
RXprimeview_dbconn <- function() dbconn(datacache)
RXprimeview_dbfile <- function() dbfile(datacache)
RXprimeview_dbschema <- function(file="", show.indices=FALSE) dbschema(datacache, file=file, show.indices=show.indices)
RXprimeview_dbInfo <- function() dbInfo(datacache)

RXprimeviewORGANISM <- "Homo sapiens"

.onLoad <- function(libname, pkgname)
{
    ## Connect to the SQLite DB
    dbfile <- system.file("extdata", "RXprimeview.sqlite", package=pkgname, lib.loc=libname)
    assign("dbfile", dbfile, envir=datacache)
    dbconn <- dbFileConnect(dbfile)
    assign("dbconn", dbconn, envir=datacache)

    ## Create the OrgDb object
    sPkgname <- sub(".db$","",pkgname)
    txdb <- loadDb(system.file("extdata", paste(sPkgname,
      ".sqlite",sep=""), package=pkgname, lib.loc=libname),
                   packageName=pkgname)    
    dbNewname <- AnnotationDbi:::dbObjectName(pkgname,"ChipDb")
    ns <- asNamespace(pkgname)
    assign(dbNewname, txdb, envir=ns)
    namespaceExport(ns, dbNewname)
        
    ## Create the AnnObj instances
    ann_objs <- createAnnObjs.SchemaChoice("HUMANCHIP_DB", "RXprimeview", "chip RXprimeview", dbconn, datacache)
    mergeToNamespaceAndExport(ann_objs, pkgname)
    packageStartupMessage(AnnotationDbi:::annoStartupMessages("RXprimeview.db"))
}

.onUnload <- function(libpath)
{
    dbFileDisconnect(RXprimeview_dbconn())
}

