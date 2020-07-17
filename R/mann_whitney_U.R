# mann_whitney_U.R
#
# Henri Kauhanen 2016-2020
#
# Mann-Whitney U test for the two main root classes. We use this instead of
# the more conventional t-test as the assumption of normality cannot be
# held for our sample.


mann_whitney_U <- function(data,
                           exact=FALSE, 
                           paired=FALSE, 
                           alternative = "greater", 
                           ...) {
  propcon <- data[data$Root.Class == "property concept", ]$PropFilled
  resroot <- data[data$Root.Class == "result roots", ]$PropFilled
  wilcox.test(x=propcon, y=resroot, exact=exact, paired=paired, alternative=alternative, ...)
}


