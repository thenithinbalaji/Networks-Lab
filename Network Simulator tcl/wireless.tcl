# Define options
set val(chan)           Channel/WirelessChannel    ;# channel type
set val(prop)           Propagation/TwoRayGround   ;# radio-propagation model
set val(netif)          Phy/WirelessPhy            ;# network interface type
set val(mac)            Mac/802_11                 ;# MAC type
set val(ifq)            Queue/DropTail/PriQueue    ;# interface queue type
set val(ll)             LL                         ;# link layer type
set val(ant)            Antenna/OmniAntenna        ;# antenna model
set val(ifqlen)         1                         ;# max packet in ifq
set val(nn)             6                          ;# number of mobilenodes
set val(rp)             DSDV                       ;# routing protocol
set val(x)              500                        ;# X dimension of topography
set val(y)              400                        ;# Y dimension of topography 
set val(stop)           15                   ;# time of simulation end

set ns              [new Simulator]
#Creating nam and trace file:

set tracefd       [open wireless1.tr w]
set namtrace      [open wireless1.nam w]   
$ns trace-all $tracefd
$ns namtrace-all-wireless $namtrace $val(x) $val(y)

# set up topography object
set topo       [new Topography]

$topo load_flatgrid $val(x) $val(y)

set god_ [create-god $val(nn)]

# configure the nodes

$ns node-config -adhocRouting $val(rp) \
                   -llType $val(ll) \
                   -macType $val(mac) \
                   -ifqType $val(ifq) \
                   -ifqLen $val(ifqlen) \
                   -antType $val(ant) \
                   -propType $val(prop) \
                   -phyType $val(netif) \
                   -channelType $val(chan) \
                   -topoInstance $topo \
                   -agentTrace ON \
                   -routerTrace ON \
                   -macTrace OFF \
                   -movementTrace ON
 
     ## Creating node objects..         
for {set i 0} {$i < $val(nn) } { incr i } {
            set node_($i) [$ns node]     
      	    $node_($i) random-motion 0
	}
for {set i 0} {$i < $val(nn)  } {incr i } {
            $node_($i) color black
            $ns at 0.0 "$node_($i) color black"
      }
    ## Provide initial location of mobilenodes..
for {set i 0} {$i < $val(nn) } { incr i } {
            set xx [expr rand()*500]
            set yy [expr rand()*400]
            $node_($i) set X_ $xx
            $node_($i) set Y_ $yy
         }
       set tcp [new Agent/TCP]
       $tcp set class_ 2
       set sink [new Agent/TCPSink]
       $ns attach-agent $node_(0) $tcp
       $ns attach-agent $node_(5) $sink
       $ns connect $tcp $sink
      
       set ftp [new Application/FTP]
       $ftp attach-agent $tcp
       $ns at 1.0  "$ftp start"
       $ns at 15.0 "$ftp stop"

     # Define node initial position in nam
for {set i 0} {$i < $val(nn)} { incr i } {
     # 30 defines the node size for nam
     $ns initial_node_pos $node_($i) 30
     }
    
    #mobility creation
    $ns at 3.0 "$node_(1) setdest 25.0 20.0 15.0"
    $ns at 4.0 "$node_(0) setdest 20.0 18.0 1.0"
    $ns at 5.0 "$node_(1) setdest 90.0 80.0 15.0"
    
    # Telling nodes when the simulation ends
for {set i 0} {$i < $val(nn) } { incr i } {
    $ns at $val(stop) "$node_($i) reset";
    }

    #Destination procedure..
    $ns at 0.0 "destination"
    proc destination {} {
	      global ns val node_
	      set time 1.0
	      set now [$ns now]
	      for {set i 0} {$i<$val(nn)} {incr i} {
	            set xx [expr rand()*500]
	            set yy [expr rand()*400]
	      }

    $ns at [expr $now+$time] "destination"
    }

    $ns at $val(stop) "stop"
    
    #Stop procedure
    proc stop {} {
	    global ns tracefd namtrace
	    $ns flush-trace
	    close $tracefd
	    close $namtrace
	    exec nam wireless1.nam &
	}

$ns run