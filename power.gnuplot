set title "Power use over the Last \\~48 Hours"
set xtics 7200 rotate by 30 offset -5.7, -2.2
set y2tics 
set key outside below
set xlabel "Time (UTC)" offset 0.0, -1.6;
set xdata time;
set format x "%F\n%TZ"
set timefmt "%Y%m%dT%H%M%S"
set grid
set term png size 1900, 512 font ",10"

# set 4 decimal places just for testing to make sure we have the right cols
set format y "%.4f"
set format y2 "%.4f"

set ylabel "(W)"
set y2label "(W)"

dat_f='/home/ghz/power_wx/data/2-3_day.power'

set output '/home/ghz/power_wx/plots/power.ph_0.png'
plot dat_f using 1:3 title 'Power Use (phase 0, Watts)' with lines linecolor rgb "#00ff00"

set output '/home/ghz/power_wx/plots/power.ph_1.png'
plot dat_f using 1:6 title 'Power Use (phase 1, Watts)' with lines linecolor rgb "#00ffff"

set output '/home/ghz/power_wx/plots/power.ph_2.png'
plot dat_f using 1:9 title 'Power Use (phase 2, Watts)' with lines linecolor rgb "#ff00ff"

set output '/home/ghz/power_wx/plots/power.ph_0+1+2.png'
plot dat_f using 1:($3+$6+$9) title 'Power Use (phase 0+1+2, Watts)' with lines linecolor rgb "#ff0000"

set ylabel "(V)"
set y2label "(V)"

set title "Battery Voltage over the Last \\~48 Hours"
set output '/home/ghz/power_wx/plots/power.batt.png'
plot dat_f using 1:12 title 'Battery Voltage (Volts)' with lines linecolor rgb "#0000ff"
