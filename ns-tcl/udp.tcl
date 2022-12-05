set ns [new Simulator]
set nf [open out.nam w]

$ns namtrace-all $nf

proc finish {} {
	global ns nf
	$ns flush-trace
	close $nf
	
	exec nam out.nam &
	exit 0
}

set n0 [$ns node]
set n1 [$ns node]

$ns duplex-link $n0 $n1 10Mb 1ms DropTail

set udp [new Agent/UDP] #for tcp change this to TCP
$ns attach-agent $n0 $udp

set null [new Agent/Null] #for tcp change this to TCPSink
$ns attach-agent $n1 $null

set cbr [new Application/Traffic/CBR] #for tcp change this FTP
$cbr attach-agent $udp

$ns connect $udp $null

$ns at 1 "$cbr start"
$ns at 3 "$cbr stop"
$ns at 5 "finish"

$ns run