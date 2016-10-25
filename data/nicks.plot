# This script only works with gnuplot 3.x
set timefmt "%Y/%m/%d"
set timestamp "%d %b %Y" top
set xdata time
set term png small
set title "Nicks balance"
set output "nicks_delta.png"
plot 'history30.log' u 1:($4 - $5) t "Delta" w l
set output "nicks_total.png"
set title "Total nicks - last 30 days"" 
plot 'history180.log' u 1:3 t "Total nicks" w l
set title "Total nicks"
set output "nicks_30.png"
plot 'history30.log' using 1:3 title "Total nicks" with lines
