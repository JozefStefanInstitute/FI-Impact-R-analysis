# --------------------
# Functions
# --------------------

# Save boxplots for given scores and categories
save.boxplots <- function(db, scores, categories) {
  for (score in scores) for (category in categories) {
    dt = get.pair.df(score, category)
    colnames(dt) <- c('score', 'category')
    jpeg(file = paste("boxplots/", category, "-", score, ".jpg", sep = ""))
    if (category %in% features.keyword('binary')) {
      par(mar = c(4, 4, 4, 4))
      boxplot(score ~ category, data = dt, main = paste(get.label(category), '-', get.label(score)), notch=TRUE)
    }
    else {
      par(mar = c(10, 4, 4, 2))
      boxplot(score ~ category, data = dt, las = 2, main = get.label(score), notch=TRUE)
    }
    dev.off()
  }
}
# Save boxplot sample sizes for given scores and categories
save.boxplot.sample.sizes <- function(db, scores, categories) {
  for (category in categories) {
    parts = split(db[c(category, scores)], db[category])
    options = names(parts)
    m = length(options)
    n = length(scores)
    a = mat.or.vec(m, n)
    rownames(a) = options
    colnames(a) = scores
    for (i in c(1:m)) for (j in c(1:n)) a[i, j] = nrow(parts[[options[i]]])
    write.csv(a, file = paste('output/boxplot-', category, '.csv', sep = ''))
  }
}

# --------------------
# Computations
# --------------------

boxplots = c('Accelerator', features.keyword('category'), features.keyword('binary'))
save.boxplots(db, benchmark.numeric, boxplots)
save.boxplot.sample.sizes(db, benchmark.numeric, boxplots)
