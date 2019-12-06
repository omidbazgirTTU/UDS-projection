# UDS-projection

1) Lets compute the pairwise drug distance-- this paper provides a review of similarity measures https://iopscience.iop.org/article/10.1088/1742-6596/892/1/012015
2) Next, we use this distance matrix and project them on a compact subset of R^1. you can use R package PACE and the relevant projection is known as Stringing http://anson.ucdavis.edu/~mueller/data/software.html
3) Once, the projection is performed then each drug has a location in R^1.
    Now you can plot the AUC (or IC50) of each drug on their respective locations. Therefore you will end up with a 1D function for each subject.
4) Now for each subject perform an ACF plot. The horizontal axis of ACF plot is the lag in drug space and the vertical axis is the correlation of responses. If it is stationary, the correlation will decrease as lag increases. Our hunch is that, you will see non-monotonic relationship between lag and correlation.
5) We can then perform a formal test of stationarity in R. See adf.test in package t series. If we fail to reject the null, we establish non-stationarity.
