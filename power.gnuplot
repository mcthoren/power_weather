set title "Power use over the Last \\~24 Hours"
set xtics 7200 rotate by 30 offset -5.7, -2.2
set y2tics 
set key outside below
set xlabel "Time (UTC)" offset 0.0, -1.6;
set xdata time;
set format x "%F\n%TZ"
set timefmt "%Y%m%d%H%M%S"
set grid
set term png size 1900, 512 font ",10"

set format y "%.0f"
set format y2 "%.0f"

set ylabel "(W)"
set y2label "(W)"

dat_f='/home/ghz/power_wx/data/power.24_hours'

# in theory, if we measure peak to peak AC voltage with a current probe that
# reads 1V for every 15A, and if our voltage and current are in phase. then:
# rms power [W] = current probe reading [Vpp] * sqrt(2) * line voltage [Vrms] * 15[A/V]
# thereby yielding sth like:
# p_v2w = .707106781 * 236 * 15 # theoretical power via voltage to watts conv.

# in practice we observe wildly different values for each probe, and hopes of
# linearity are also diminishing. we can be also be sure that our voltage and
# current and not drawn in phase, and that thish phase difference is
# dynamic. this is going to remain a dev project for a bit longer yet.
pp_v2w_0 = 1442		# in practice power via voltage to watts conv.
p1(x) = (845 * x + 46)	# power in watts from probe voltage conv func. this is better. but needs more work.

set output '/home/ghz/power_wx/plots/power.ph_0.png'
plot dat_f using 1:($3 * pp_v2w_0) title 'Power Use (Main Phase, Watts)' with lines linecolor rgb "#00ff00"

set output '/home/ghz/power_wx/plots/power.ph_1.png'
plot dat_f using 1:(p1($6)) title 'Power Use (DDR Kitchen Outlets, Watts)' with lines linecolor rgb "#00ffff"

set logscale yy2
set title "Power use (log scale) over the Last \\~24 Hours"

# this is an incredibly hacky way to get both the y and y2 ranges to be the same
# in gnuplot. i could fill a page with all the things i've tried that one might
# expect to work, but wind up producing an invalid y2range that then throws a
# warning when the y2tics are set even tho the yrange is valid. i don't know why.
unset y2tics
set output "| cat > /dev/null"
plot dat_f using 1:($3 * pp_v2w_0) title 'Log Power Use (Main Phase, Watts)' with lines linecolor rgb "#00ff00"

set y2range [GPVAL_Y_MIN:GPVAL_Y_MAX]
set y2tics
set output '/home/ghz/power_wx/plots/power.ph_0_log.png'
plot dat_f using 1:($3 * pp_v2w_0) title 'Log Power Use (Main Phase, Watts)' with lines linecolor rgb "#00ff00"


unset y2tics
set output "| cat > /dev/null"
plot dat_f using 1:(p1($6)) title 'Log Power Use (DDR Kitchen Outlets, Watts)' with lines linecolor rgb "#00ffff"

set y2range [GPVAL_Y_MIN:GPVAL_Y_MAX]
set y2tics
set output '/home/ghz/power_wx/plots/power.ph_1_log.png'
plot dat_f using 1:(p1($6)) title 'Log Power Use (DDR Kitchen Outlets, Watts)' with lines linecolor rgb "#00ffff"

unset logscale
unset y2range

set title "Temperature of the power Pi processor over the Last \\~24 Hours"
set ylabel "(°C)"
set y2label "(°C)"
set output '/home/ghz/power_wx/plots/pitemp.png'
plot dat_f using 1:15 title 'Pi Temp (°C)' with lines linecolor rgb "#ff0000" smooth bezier
