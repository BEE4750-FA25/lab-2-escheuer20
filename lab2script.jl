import Pkg
Pkg.activate(".")
Pkg.instantiate()

using Random # random number generation
using Distributions # probability distributions and interface
using Statistics # basic statistical functions, including mean
using Plots # plotting

#set random seed
Random.seed!(1)

L = 200000 #max loss
k = 0.08 #slope of depth damage relationship
h0 = 3 # inflection point
h_log = LogNormal(1.2,0.3)
h_ev = GeneralizedExtremeValue(3, 0.9, -0.15)

#function to determine losses based on equation given in instructions
function flood(L, k,h, h0)
    d = 1- exp(k*(h-h0))
    return L/d
end

log_samples = rand(h_log, 1000)
histogram(log_samples, legend=:false, bins=50)
ylabel!("Count")
xlabel!("h0 value")
title!("Sample of LogNormal distribution")

ev_samples = rand(h_ev, 1000)
histogram(ev_samples, legend=:false, bins=50)
ylabel!("Count")
xlabel!("h0 value")
title!("Sample of Generalized Extreme Value distribution")