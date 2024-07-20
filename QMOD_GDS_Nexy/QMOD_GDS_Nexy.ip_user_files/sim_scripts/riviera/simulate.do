transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+waves  -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.waves xil_defaultlib.glbl

do {waves.udo}

run 1000ns

endsim

quit -force
