## Packages
library(reshape)
library(lubridate)
library(ggplot2)
library(tidyverse)
library(foreign)
library(patchwork)
library(kableExtra)
library(RColorBrewer)
library(rstan)

## File paths
dataFolder <- "./proc_data"
scriptFolder <- "./scripts"
outputFolder <- "./figures"

## Options
options(scipen = 6, digits = 4) # output is displayed with 4 decimal digits

## disable labels for ggplot2 graphics
axis_theme <- theme(axis.title.y=element_blank(),
                    axis.ticks.y=element_blank(),
                    axis.title.x=element_blank(),
                    axis.text.x=element_blank(),
                    axis.ticks.x=element_blank(),
                    legend.position = "none")