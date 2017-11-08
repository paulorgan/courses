#########################################################################################
# Date:    2017-11-08
# Author:  Paul Organ
# Purpose: ECON 605.2 - PS1
###############################################################################
# setup
setwd('C:/Users/Paul Organ/Desktop/R/')

# for analysis
require(expm)
require(markovchain)

# for syntax
require(dplyr)
require(magrittr)

###############################################################################
# question 1
# with help from http://blog.revolutionanalytics.com/2016/01/getting-started-with-markov-chains.html

state_names <- c('Boom', 'Recession')

# generate Markov Chain object with our given transition matrix
mc <- new('markovchain',
          transitionMatrix = matrix(c(.9, .1, .25, .75), byrow=T, nrow=2),
          states = state_names)

# Q1.a - what is the ergodic distribution?
erg <- steadyStates(mc)
# ergodic distribution is (.714, .286)'

# Q1.b - what is the average growth rate?
# first, input average quarterly rates under boom and bust
boom_bust_rates <- c(1.2, -0.4)
# then average is the weighted rate given our unconditional probabilities above
avg <- sum(erg*boom_bust_rates)
# average growth rate is 0.7429% per quarter

# Q1.c - expected length of boom given currently in boom?
# P(Boom to Boom = .9), P(Boom to Bust = .1)
# Can model as though a geometric r.v., E=1/p, p=.1
exp_boom_length = 1 / .1
# expected boom length is 10 periods, or 2.5 years

# Q1.d - given Boom, what is P(Boom in 2 years)?
p <- matrix(c(.9, .1, .25, .75), byrow=T, nrow=2,
            dimnames = list(state_names, state_names))
# using %^% operator from expm package to take p to the 8th power (2 years)
p_8 <- p %^% 8
# given Boom now, probability of Boom in 8 periods 0.7234

# clean up
rm(list=ls())

###############################################################################
# question 3

# set up
wages <- 10 * matrix(1:10) # 1x10 matrix of wages
probs <- rnorm(10, mean = 55, sd = 15) %>% matrix %>% 
probs <- probs/sum(probs) # 1x10 matrix of probabilities
beta <- .9 # discount factor


###############################################################################
# fin.
###############################################################################