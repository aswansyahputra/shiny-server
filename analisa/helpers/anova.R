library(tidyverse)
library(lmerTest)
library(emmeans)
library(SensoMineR)

str(sensochoc)
dat <- as_tibble(sensochoc)
firstvar <- 5
vars <- names(sensochoc)[firstvar:ncol(sensochoc)]
models <- lapply(setNames(vars, vars), function(var, data) {
  if (any("Session" %in% names(data))){
    form = paste(var, "~ Product+Session+Product:Session+(1|Panelist)+(1|Product:Panelist)+(1|Panelist:Session)")
  } else {
    form = paste(var, "~ Product+(1|Panelist)+(1|Product)")
  }
  lmerTest::lmer(form, data = data) %>% 
    anova() %>%
    as_tibble(validate = FALSE, rownames = "Source")
  # lmerTest::lmer(form, data = data) %>% 
  #   emmeans(specs = "Product", lmer.df = "satterthwaite")) %>% 
  #   cld(Letters = letters) %>% 
  #   ggplot(aes(x = Product, y = emmean)) +
  #   geom_bar(stat = "identity") +
  #   geom_errorbar(aes(ymin = lower.CL, ymax = upper.CL), width = 0.2) +
  #   labs(x = "", y = "Rerata") +
  #   theme_bw()

}, data = dat)
names(models) <- vars