## verify probes and genes exist (for the chip packages)
library(DBI)
getProbes <- function(){
    require("RXprimeview.db")
    as.numeric(dbGetQuery(dbconn(RXprimeview.db),
                          "SELECT count(DISTINCT probe_id) FROM probes"))
}

msg = paste("This package has no probes. This can be caused by a large number ",
  "of upstream changes. But it's usually caused by alterations to the source ",
  "files used to extrac the probes at the very beginning.", sep="")

checkTrue(getProbes() > 0,
          msg = paste(strwrap(msg, exdent=2),collapse="\n") )


getGenes <- function(){
    require("RXprimeview.db")
    as.numeric(dbGetQuery(dbconn(RXprimeview.db),
                 "SELECT count(DISTINCT gene_id) FROM probes"))
}

msg = paste("This package has no genes. This can be caused by a large number ",
  "of upstream changes. But it's usually caused by alterations to the source ",
  "files used to extrac the probes at the very beginning.", sep="")

checkTrue(getGenes() > 0,
          msg = paste(strwrap(msg, exdent=2),collapse="\n") )

