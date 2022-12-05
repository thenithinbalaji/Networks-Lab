set ns [new Simulator]
set nf [open out.nam w]
set nt [open out.tr w]

$ns namtrace-all $nf
$ns trace-all $nt

proc finish {} {
	global ns nf nt
	$ns flush-trace
	close $nf
	close $nt
	exec nam out.nam &
	exit 0
}

set n0 [$ns node]
set n1 [$ns node]

$ns duplex-link $n0 $n1 10Mb 1ms DropTail

set tcp [new Agent/TCP]
$ns attach-agent $n0 $tcp

set sink [new Agent/TCPSink]
$ns attach-agent $n1 $sink

set ftp [new Application/FTP] 
$ftp attach-agent $tcp

$ns connect $tcp $sink

$ns at 1 "$ftp start"
$ns at 3 "$ftp stop"
$ns at 5 "finish"

$ns run