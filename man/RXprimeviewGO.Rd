\name{RXprimeviewGO}
\alias{RXprimeviewGO}
\alias{RXprimeviewGO2PROBE}
\alias{RXprimeviewGO2ALLPROBES}
\title{Maps between manufacturer IDs and Gene Ontology (GO) IDs}
\description{
  RXprimeviewGO is an R object that provides mappings between
  manufacturer identifiers and the GO identifiers that they are directly
  associated with. This mapping and its reverse mapping
  (RXprimeviewGO2PROBE) do NOT associate the child terms from the GO
  ontology with the gene.  Only the directly evidenced terms are
  represented here.

  RXprimeviewGO2ALLPROBES is an R object that provides mappings between
  a given GO identifier and all of the manufacturer identifiers
  annotated at that GO term OR TO ONE OF IT'S CHILD NODES in the GO
  ontology.  Thus, this mapping is much larger and more inclusive than
  RXprimeviewGO2PROBE.
}
\details{
  If RXprimeviewGO is cast as a list, each manufacturer identifier is
  mapped to a list of lists.  The names on the outer list are GO
  identifiers.  Each inner list consists of three named elements: GOID,
  Ontology, and Evidence.

  The GOID element matches the GO identifier named in the outer list and
  is included for convenience when processing the data using 'lapply'.

  The Ontology element indicates which of the three Gene Ontology
  categories this identifier belongs to.  The categories are biological
  process (BP), cellular component (CC), and molecular function (MF).
     
  The Evidence element contains a code indicating what kind of evidence
  supports the association of the GO identifier to the manufacturer
  id. Some of the evidence codes in use include:

  IMP: inferred from mutant phenotype  

  IGI: inferred from genetic interaction

  IPI: inferred from physical interaction  

  ISS: inferred from sequence similarity 

  IDA: inferred from direct assay  

  IEP: inferred from expression pattern  

  IEA: inferred from electronic annotation  

  TAS: traceable author statement  

  NAS: non-traceable author statement  

  ND: no biological data available  

  IC: inferred by curator

  A more complete listing of evidence codes can be found at:

  \url{http://www.geneontology.org/GO.evidence.shtml}

    
  If RXprimeviewGO2ALLPROBES or RXprimeviewGO2PROBE is cast as a list,
  each GO term maps to a named vector of manufacturer identifiers and
  evidence codes. A GO identifier may be mapped to the same manufacturer
  identifier more than once but the evidence code can be
  different. Mappings between Gene Ontology identifiers and Gene
  Ontology terms and other information are available in a separate data
  package named GO.
  
  Whenever any of these mappings are cast as a data.frame, all the
  results will be output in an appropriate tabular form.
  
  Mappings between manufacturer identifiers and GO information were
  obtained through their mappings to manufacturer identifiers. NAs are
  assigned to manufacturer identifiers that can not be mapped to any Gene
  Ontology information. Mappings between Gene Ontology identifiers an
  Gene Ontology terms and other information are available in a separate
  data package named GO.
  
  All mappings were based on data provided by: Gene Ontology  
  http://current.geneontology.org/ontology/go-basic.obo  
  With a date stamp from the source of: 2021-09-01
}

\references{
\url{ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/}
}

\seealso{
  \itemize{
    \item \code{\link{RXprimeviewGO2ALLPROBES}}
    \item \code{\link[AnnotationDbi]{AnnotationDb-class}} for use of
          the \code{select()} interface.
  }
}

\examples{
## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- RXprimeviewGO
# Get the manufacturer identifiers that are mapped to a GO ID
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes][1:300])
if(length(xx) > 0) {
    # Try the first one
    got <- xx[[1]]           
    got[[1]][["GOID"]]
    got[[1]][["Ontology"]]
    got[[1]][["Evidence"]]
}
# For the reverse map:
x <- RXprimeviewGO2PROBE
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes][1:300])
if(length(xx) > 0){
    # Gets the manufacturer ids for the top 2nd and 3nd GO identifiers
    goids <- xx[2:3]
    # Gets the manufacturer ids for the first element of goids
    goids[[1]]
    # Evidence code for the mappings
    names(goids[[1]])
}

x <- RXprimeviewGO2ALLPROBES
mapped_genes <- mappedkeys(x)
# Convert RXprimeviewGO2ALLPROBES to a list
xx <- as.list(x[mapped_genes][1:300])
if(length(xx) > 0){
# Gets the manufacturer identifiers for the top 2nd and 3nd GO identifiers
    goids <- xx[2:3]
    # Gets all the manufacturer identifiers for the first element of goids
    goids[[1]]
    # Evidence code for the mappings
    names(goids[[1]])
}
}

\keyword{datasets}
