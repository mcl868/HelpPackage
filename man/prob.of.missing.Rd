\name{prob.of.missing}
\alias{prob.of.missing}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
prob.of.missing
}
\description{
  A concise (1-5 lines) description of what the function does. 
}
\usage{
prob.of.missing(object, regression, list.out = TRUE, completecase = FALSE, regList, order = NULL, ...) 
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
%%     ~~Describe \code{x} here~~
}
  \item{regression}{
%%     ~~Describe \code{x} here~~
}
  \item{list.out}{
%%     ~~Describe \code{x} here~~
}
  \item{completecase}{
%%     ~~Describe \code{x} here~~
}
  \item{regList}{
%%     ~~Describe \code{x} here~~
}
  \item{order}{
%%     ~~Describe \code{x} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
put references to the literature/web site here
}
\author{
Thomas Maltesen
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{

regList<-list()
regList[[1]]<-"L0"
regList[[2]]<-"L0 + X0"
regList[[3]]<-"L0 + X0 + L1"
regList[[4]]<-"L0 + X0 + L1 + X1"
regList[[5]]<-"L0 + X0 + L1 + X1 + L2"
regList[[6]]<-"L0 + X0 + L1 + X1 + L2 + X2 + X1*X2"


misdata<-missing.pattern(response = "Y",
                         covariates = c("L0","X0","L1","X1","L2","X2"),
                         data = DataSetListNA[[iiii]],
                         pattern = "Monotone")
DataSetobj<-prob.of.missing(misdata, regList = regList)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
