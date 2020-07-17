# plotting.R
#
# Henri Kauhanen 2016-2020
#
# Plotting routines. Quickly cobbled together from old resources and not really polished
# in any way, so apologies for all the bricolage.


require(ggplot2)
require(gridExtra)


color1 <- "#a6cee3"
color2 <- "#b2df8a"


# Visualize by root class (PC roots vs. result roots).
violinplot_by_root_class <- function(df,
                                     mar = c(3, 6, 1, 1) - 0.5,
                                     horizontal = TRUE,
                                     las = 1,
                                     xlab = "",
                                     ylim = c(0,1),
                                     ...) {
  #  op <- par(mar=mar)
  df <- droplevels(df)
  df$rc <- df$Root.Class
  df$filled_prop <- df$PropFilled
  df <- df[df$rc != "", ]
  df$rc <- factor(df$rc, rev(c("property concept", "result roots")))
  levels(df$rc) <- c("result roots", "PC roots")
  print(
        ggplot(df, aes(rc, filled_prop, fill=rc, color=rc))
        + geom_violin(trim=FALSE) 
        #        + geom_boxplot(color="#333333", outlier.alpha=0, width=0.5)
        #        + stat_summary(fun.y=median, geom="point", shape="|", color="white", size=20, stroke=1.0)
        + geom_jitter(position=position_jitter(width=0.3, height=0.0), shape=1, stroke=1.0, size=1.0, alpha=0.5, color="black")
        #        + geom_jitter(shape=1, stroke=1.0, size=1.0, alpha=0.5, color="black", width=0.3, height=0.0)
                + stat_summary(fun.y=median, geom="point", shape="|", color="black", size=9, stroke=1.0)
        #+ stat_summary(fun.y=median, geom="point", shape=23, color="black", size=2.5, stroke=1.1, bg="white")
        #        + stat_summary(fun.data=mean_sdl, fun.args=list(mult=1), geom="pointrange", color="black", shape="|")
        + scale_y_continuous(labels=c("0%", "25%", "50%", "75%", "100%"), breaks=c(0, 0.25, 0.5, 0.75, 1), limits=c(-0.01,1.01), name="")
        + coord_flip() 
        + theme_light()
        #        + ylim(-0.01,1.01) 
        + xlab("") 
        #        + ylab("") 
        + scale_color_manual(values=rev(c(color1, color2)))
        + scale_fill_manual(values=rev(c(color1, color2)))
        + theme(text = element_text(size=14), legend.position="none", axis.text=element_text(colour="black"), plot.margin=margin(l=-0.3, r=0.2, b=-0.3, t=0.2, unit="cm"))
  )
  #  par(op)
}


# Visualize by narrow root class, two violin plots on top of each other.
violinplot_by_narrow_root_class <- function(df,
                                            oma = c(3, 14, 1, 2) - 0.5,
                                            mar = c(0.1, 0, 0.1, 0),
                                            horizontal=TRUE,
                                            las = 1,
                                            xlab = "",
                                            ...) {
  plot1 <- qplot(1)
  plot2 <- qplot(1)

  df$rc <- df$Root.Class
  df <- df[df$rc != "", ]
  df$nrc <- df$Narrow.Root.Class
  df$filled_prop <- df$PropFilled

  masterdf <- df
  df <- df[df$rc == "property concept", ]
  df <- droplevels(df)
  PCnames <- unique(df$nrc)

  #plot1 <- ggplot(df, aes(reorder(nrc, filled_prop, median), filled_prop)) + geom_violin(trim=TRUE, color=color1, fill=color1) + geom_jitter(position=position_jitter(width=0.2, height=0.0), shape=1, stroke=1.0, size=1.0, alpha=0.5, color="black") + stat_summary(fun.y=median, geom="point", shape="|", color="black", size=4, stroke=3.0) + coord_flip() + theme_light() + xlab("") + theme(text = element_text(size=14), legend.position="none", plot.title=element_text(size=12, hjust=0.5), plot.margin=margin(l=2.58, r=0.2, b=0.0, t=0.2, unit="cm"), axis.text=element_text(color="black")) + ggtitle("PC roots") + scale_y_continuous(labels=c("0%", "25%", "50%", "75%", "100%"), breaks=c(0, 0.25, 0.5, 0.75, 1), limits=c(-0.01,1.01), name="")
  #plot1 <- ggplot(df, aes(reorder(nrc, filled_prop, median), filled_prop)) + geom_violin(trim=TRUE, color=color1, fill=color1) + geom_jitter(position=position_jitter(width=0.2, height=0.0), shape=1, stroke=1.0, size=1.0, alpha=0.5, color="black") + stat_summary(fun.y=median, geom="point", shape=23, color="black", size=2.0, stroke=0.9, bg="white") + coord_flip() + theme_light() + xlab("") + theme(text = element_text(size=14), legend.position="none", plot.title=element_text(size=12, hjust=0.5), plot.margin=margin(l=2.58, r=0.2, b=0.0, t=0.2, unit="cm"), axis.text=element_text(color="black")) + ggtitle("PC roots") + scale_y_continuous(labels=c("0%", "25%", "50%", "75%", "100%"), breaks=c(0, 0.25, 0.5, 0.75, 1), limits=c(-0.01,1.01), name="")
  plot1 <- ggplot(df, aes(reorder(nrc, filled_prop, median), filled_prop)) + geom_violin(trim=TRUE, color=color1, fill=color1) + geom_jitter(position=position_jitter(width=0.2, height=0.0), shape=1, stroke=1.0, size=1.0, alpha=0.5, color="black") + stat_summary(fun.y=median, geom="point", shape="|", color="black", size=6, stroke=1.0) + coord_flip() + theme_light() + xlab("") + theme(text = element_text(size=14), legend.position="none", plot.title=element_text(size=12, hjust=0.5), plot.margin=margin(l=2.58, r=0.2, b=0.0, t=0.2, unit="cm"), axis.text=element_text(color="black")) + ggtitle("PC roots") + scale_y_continuous(labels=c("0%", "25%", "50%", "75%", "100%"), breaks=c(0, 0.25, 0.5, 0.75, 1), limits=c(-0.01,1.01), name="")

  df <- masterdf
  df <- df[df$rc == "result roots", ]
  df <- droplevels(df)
  RRnames <- unique(df$nrc)

  #plot2 <- ggplot(df, aes(reorder(nrc, filled_prop, median), filled_prop)) + geom_violin(trim=TRUE, color=color2, fill=color2) + geom_jitter(position=position_jitter(width=0.2, height=0.0), shape=1, stroke=1.0, size=1.0, alpha=0.5, color="black") + stat_summary(fun.y=median, geom="point", shape="|", color="black", size=4, stroke=3.0) + coord_flip() + theme_light() + xlab("") + theme(text = element_text(size=14), legend.position="none", plot.title=element_text(size=12, hjust=0.5), plot.margin=margin(l=-0.3, r=0.2, b=-0.3, t=0.2, unit="cm"), axis.text=element_text(color="black")) + labs(title="result roots") + scale_y_continuous(labels=c("0%", "25%", "50%", "75%", "100%"), breaks=c(0, 0.25, 0.5, 0.75, 1), limits=c(-0.01,1.01), name="")
  #plot2 <- ggplot(df, aes(reorder(nrc, filled_prop, median), filled_prop)) + geom_violin(trim=TRUE, color=color2, fill=color2) + geom_jitter(position=position_jitter(width=0.2, height=0.0), shape=1, stroke=1.0, size=1.0, alpha=0.5, color="black") + stat_summary(fun.y=median, geom="point", shape=23, color="black", size=2.0, stroke=0.9, bg="white") + coord_flip() + theme_light() + xlab("") + theme(text = element_text(size=14), legend.position="none", plot.title=element_text(size=12, hjust=0.5), plot.margin=margin(l=-0.3, r=0.2, b=-0.3, t=0.2, unit="cm"), axis.text=element_text(color="black")) + labs(title="result roots") + scale_y_continuous(labels=c("0%", "25%", "50%", "75%", "100%"), breaks=c(0, 0.25, 0.5, 0.75, 1), limits=c(-0.01,1.01), name="")
  plot2 <- ggplot(df, aes(reorder(nrc, filled_prop, median), filled_prop)) + geom_violin(trim=TRUE, color=color2, fill=color2) + geom_jitter(position=position_jitter(width=0.2, height=0.0), shape=1, stroke=1.0, size=1.0, alpha=0.5, color="black") + stat_summary(fun.y=median, geom="point", shape="|", color="black", size=6, stroke=1.0) + coord_flip() + theme_light() + xlab("") + theme(text = element_text(size=14), legend.position="none", plot.title=element_text(size=12, hjust=0.5), plot.margin=margin(l=-0.3, r=0.2, b=-0.3, t=0.2, unit="cm"), axis.text=element_text(color="black")) + labs(title="result roots") + scale_y_continuous(labels=c("0%", "25%", "50%", "75%", "100%"), breaks=c(0, 0.25, 0.5, 0.75, 1), limits=c(-0.01,1.01), name="")

  grid.arrange(plot1, plot2, nrow=2, heights=c(length(PCnames)+0.5, length(RRnames)))
}


# Plot distributions of PC root and result root medians across Monte Carlo runs. Also conduct
# Mann-Whitney test on each run, and report p-values (medians and p-values are returned by
# the function).
plot_monte_carlo_medians <- function(data,
                                     hyps,
                                     which) {
  N <- length(data)
  out <- expand.grid(1:N, hyps, c("result roots", "property concept"), NA, NA)
  names(out) <- c("run", "hyps", "rc", "filled_prop", "pvalue")
  for (i in 1:nrow(out)) {
    thisdf <- data[[out[i,]$run]][[hyps]][[which]]

    thisdf$rc <- thisdf$Root.Class
    thisdf <- thisdf[thisdf$rc != "", ]
    thisdf$nrc <- thisdf$Narrow.Root.Class
    thisdf$filled_prop <- thisdf$PropFilled

    test <- mann_whitney_U(thisdf, alternative="greater")
    out[i,]$pvalue <- test$p.value
    #thisdf <- data[[out[i,]$run]][[which]]
    thisdf <- thisdf[thisdf$rc == as.character(out[i,]$rc), ]
    out[i,]$filled_prop <- median(thisdf$filled_prop)
  }
  df <- droplevels(out)
  df$rc <- factor(df$rc, rev(c("property concept", "result roots")))
  levels(df$rc) <- c("result root medians", "PC root medians")
  print(
        ggplot(df, aes(rc, filled_prop, fill=rc, color=rc))
        + geom_violin(trim=FALSE) 
        #        + geom_boxplot(color="#333333", outlier.alpha=0, width=0.5)
        #+ geom_jitter(position=position_jitter(width=0.1, height=0.001), shape=1, stroke=0.50, size=2.00, alpha=0.02, color="black")
        + geom_jitter(position=position_jitter(width=0.1, height=0.001), shape=1, stroke=0.15, size=0.55, alpha=0.10, color="black")
        #        + geom_jitter(shape=1, stroke=0.3, size=0.3, alpha=0.1, height=0, color="black")
        #        + geom_dotplot(binaxis='y', stackdir='center', dotsize=1)
        #        + stat_summary(fun.y=median, geom="point", shape="|", color="black", size=9, stroke=1.0)
        #        + stat_summary(fun.data=mean_sdl, fun.args=list(mult=1), geom="pointrange", color="black", shape="|")
        + scale_y_continuous(labels=c("0%", "25%", "50%", "75%", "100%"), breaks=c(0, 0.25, 0.5, 0.75, 1), limits=c(-0.01,1.01), name="")
        + coord_flip() 
        + theme_light()
        #        + ylim(-0.01,1.01) 
        + xlab("") 
        #        + ylab("") 
        + scale_color_manual(values=rev(c(color1, color2)))
        + scale_fill_manual(values=rev(c(color1, color2)))
        + theme(text = element_text(size=14), legend.position="none", axis.text=element_text(colour="black"), plot.margin=margin(l=-0.3, r=0.2, b=-0.3, t=0.2, unit="cm"))
  )

  # the p-values are duplicated in 'out', so get rid of duplicates
  pvalues <- out[out$rc=="result roots", ]
  pvalues <- pvalues[, c("run", "hyps", "pvalue")]
  out <- out[, c("run", "hyps", "rc", "filled_prop")]
  names(out) <- c("run", "hyps", "Root.Class", "PropFilled")
  list(medians=out, pvalues=pvalues)
}


# Plot distributions of proportions across all Monte Carlo runs for a given condition
# (with or without hypotheticals, and a required data mutation).
plot_monte_carlo_all <- function(data,
                                 hyps,
                                 which) {
  #data <- sample(data, size=100, replace=FALSE)

  df <- NULL
  for (i in 1:length(data)) {
    df <- rbind(df, data[[i]][[hyps]][[which]])
  }
  df <- droplevels(df)

  df$rc <- df$Root.Class
  df <- df[df$rc != "", ]
  df$nrc <- df$Narrow.Root.Class
  df$filled_prop <- df$PropFilled

  df$rc <- factor(df$rc, rev(c("property concept", "result roots")))
  levels(df$rc) <- c("result roots", "PC roots")
  print(
        ggplot(df, aes(rc, filled_prop, fill=rc, color=rc))
        + geom_violin(trim=FALSE) 
        + geom_jitter(position=position_jitter(width=0.1, height=0.001), shape=1, stroke=0.15, size=0.25, alpha=0.01, color="black")
        #        + geom_boxplot(color="#333333", outlier.alpha=0, width=0.5)
        #        + geom_jitter(position=position_jitter(0.1), shape=1, stroke=0.2, size=0.2, alpha=0.05, color="black", width=0)
        #        + geom_jitter(shape=1, stroke=0.2, size=0.2, alpha=0.05, color="black", width=0)
        #       + geom_dotplot(binaxis='y', stackdir='center', dotsize=1)
                        + stat_summary(fun.y=median, geom="point", shape="|", color="black", size=9, stroke=1.0)
        #+ stat_summary(fun.y=median, geom="point", shape=23, color="black", size=2.5, stroke=1.1, bg="white")
        #        + stat_summary(fun.data=mean_sdl, fun.args=list(mult=1), geom="pointrange", color="black", shape="|")
        + scale_y_continuous(labels=c("0%", "25%", "50%", "75%", "100%"), breaks=c(0, 0.25, 0.5, 0.75, 1), limits=c(-0.01,1.01), name="")
        + coord_flip() 
        + theme_light()
        #        + ylim(-0.01,1.01) 
        + xlab("") 
        #        + ylab("") 
        + scale_color_manual(values=rev(c(color1, color2)))
        + scale_fill_manual(values=rev(c(color1, color2)))
        + theme(text = element_text(size=14), legend.position="none", axis.text=element_text(colour="black"), plot.margin=margin(l=-0.3, r=0.2, b=-0.3, t=0.2, unit="cm"))
  )
}


