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
    d = 1+ exp(k*(h-h0))
    return L/d
end

log_samples = rand(h_log, 1000)
ev_samples = rand(h_ev, 1000)

# change to say depth not h0!
#=
histogram(log_samples, legend=:false, bins=50)
ylabel!("Count")
xlabel!("h0 value")
title!("Sample of LogNormal distribution")

histogram(ev_samples, legend=:false, bins=50)
ylabel!("Count")
xlabel!("h0 value")
title!("Sample of Generalized Extreme Value distribution")
=#
n = 1000:1000:500000
avg_freq = zeros(500)
std_freq = zeros(500)
for trial in 1:length(n)
    mc_log = zeros(n[trial])
    log_samples = rand(h_log, n[trial])
    #ev_samples = rand(h_ev, n[trial])
    for i in 1:n[trial]
        mc_log[i] = flood(L,k,log_samples[i], h0)
    end
    av = mean(mc_log)
    avg_freq[trial]= av
    stdev = std(mc_log) 
    std_freq[trial] = stdev
end

print(std_freq)
