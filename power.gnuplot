set title "Power use over the Last \\~48 Hours"
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

dat_f='/home/ghz/power_wx/data/power.2-3_day'

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
pp_v2w_1 = 859

set output '/home/ghz/power_wx/plots/power.ph_0.png'
plot dat_f using 1:($3 * pp_v2w_0) title 'Power Use (Main Phase, Watts)' with lines linecolor rgb "#00ff00"

set output '/home/ghz/power_wx/plots/power.ph_1.png'
plot dat_f using 1:($6 * pp_v2w_1) title 'Power Use (DDR Kitchen Outlets, Watts)' with lines linecolor rgb "#00ffff"

# set output '/home/ghz/power_wx/plots/power.ph_2.png'
# plot dat_f using 1:($9 * p_v2w) title 'Power Use (phase 2, Watts)' with lines linecolor rgb "#ff00ff"

# set output '/home/ghz/power_wx/plots/power.ph_0+1+2.png'
# plot dat_f using 1:(($3+$6+$9) * p_v2w) title 'Power Use (phase 0+1+2, Watts)' with lines linecolor rgb "#ff0000"

# set ylabel "(V)"
# set y2label "(V)"
# set format y "%.3f"
# set format y2 "%.3f"

# set title "Battery Voltage over the Last \\~48 Hours"
# set output '/home/ghz/power_wx/plots/power.batt.png'
# plot dat_f using 1:12 title 'Battery Voltage (Volts)' with lines linecolor rgb "#0000ff"

set ylabel "(°C)"
set y2label "(°C)"
set output '/home/ghz/power_wx/plots/pitemp.png'
plot dat_f using 1:15 title 'Pi Temp (°C)' with lines linecolor rgb "#ff0000" smooth bezier
