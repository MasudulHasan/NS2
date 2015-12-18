puts "AODV Routing Agents in mobile networking " 
set opt(chan)           Channel/WirelessChannel    ;# channel type 
set opt(prop)           Propagation/TwoRayGround   ;# radio-propagation model 
set opt(netif)          Phy/WirelessPhy            ;# network interface type 
set opt(mac)            Mac/802_11                 ;# MAC type 
set opt(ifq)            Queue/DropTail/PriQueue    ;# interface queue type 
set opt(ll)             LL                         ;# link layer type 
set opt(ant)            Antenna/OmniAntenna        ;# antenna model 
set opt(ifqlen)         50                         ;# max packet in ifq 
set opt(nn)             22                         ;# number of mobilenodes 
set opt(rp)             AODV                       ;# routing protocol 
set opt(x)              1800   			   ;# X dimension of topography 
set opt(y)              840   			   ;# Y dimension of topography   

### Setting The Simulator Objects
                  
      set ns_ [new Simulator]
#create the nam and trace file:
      set tracefd [open aodv.tr w]
      $ns_ trace-all $tracefd

      set namtrace [open aodv.nam w]
      $ns_ namtrace-all-wireless $namtrace  $opt(x) $opt(y)

      set topo [new Topography]
      $topo load_flatgrid $opt(x) $opt(y)
      create-god $opt(nn)
      set chan_1_ [new $opt(chan)]
      


#  Defining Node Configuration
                        
	  $ns_ node-config -adhocRouting $opt(rp) \
	   -llType $opt(ll) \
	   -macType $opt(mac) \
	   -ifqType $opt(ifq) \
	   -ifqLen $opt(ifqlen) \
	   -antType $opt(ant) \
	   -propType $opt(prop) \
	   -phyType $opt(netif) \
	   -topoInstance $topo \
	   -agentTrace ON \
	   -routerTrace ON \
	   -macTrace ON \
	   -movementTrace ON \
	   -channel $chan_1_

###  Creating The WIRELESS NODES
                  
	
      for {set i 0} {$i < 23 } { incr i } {

        set mnode_($i) [$ns_ node]
      }    
###  Setting The Initial Positions of Nodes
	for {set i 0} {$i < 23 } { incr i } {

        	$mnode_($i) set X_ [ expr {$i * rand() * 71} ]
		$mnode_($i) set Y_ [ expr {$i * 79} ]
		$mnode_($i) set Z_ 0.0
	}
      
      
      ## Giving Mobility to Nodes
	
	
      $ns_ at 0.20 "$mnode_(2) setdest 309.0 211.0 20.0"
      $ns_ at 1.25 "$mnode_(3) setdest 179.0 333.0 20.0"
      $ns_ at 0.75 "$mnode_(4) setdest 139.0 63.0 20.0"
      $ns_ at 0.75 "$mnode_(5) setdest 320.0 27.0 20.0"
      $ns_ at 1.50 "$mnode_(6) setdest 505.0 124.0 20.0"
      $ns_ at 1.25 "$mnode_(7) setdest 274.0 487.0 20.0"
      $ns_ at 1.25 "$mnode_(8) setdest 494.0 475.0 20.0"
      $ns_ at 1.25 "$mnode_(9) setdest 899.0 757.0 25.0"
      $ns_ at 0.50 "$mnode_(10) setdest 598.0 728.0 25.0"
      $ns_ at 0.25 "$mnode_(11) setdest 551.0 624.0 25.0"
      $ns_ at 1.25 "$mnode_(12) setdest 397.0 647.0 25.0"
      $ns_ at 1.25 "$mnode_(13) setdest 748.0 688.0 25.0"
      $ns_ at 1.25 "$mnode_(16) setdest 842.0 623.0 25.0"
      $ns_ at 1.25 "$mnode_(18) setdest 678.0 548.0 25.0"
      $ns_ at 0.75 "$mnode_(20) setdest 741.0 809.0 20.0"
      
            
      ## Setting The Node Size
                              
	for {set i 0} {$i < 23 } { incr i } {

            $ns_ initial_node_pos $mnode_($i) 71+i*100
		
	}   

      #### Setting The Labels For Nodes
      
      
      

	for {set i 0} {$i < 11 } { incr i } {
	$mnode_($i) color green
	$ns_ at 0.0 "$mnode_($i) color red"
}
	for {set i 11} {$i < 20 } { incr i } {
	$mnode_($i) color yellow
	$ns_ at 0.0 "$mnode_($i) color blue"
}
	for {set i 20} {$i < 23 } { incr i } {
	$mnode_($i) color pink
	$ns_ at 0.0 "$mnode_($i) color green"
}

      
     

      ## SETTING ANIMATION RATE 
$ns_ at 0.0 "$ns_ set-animation-rate 12.5ms"

  
                  
####  Establishing Communication

      set udp0 [$ns_ create-connection UDP $mnode_(12) LossMonitor $mnode_(18) 0]
      $udp0 set fid_ 1
      set cbr0 [$udp0 attach-app Traffic/CBR]
      $cbr0 set packetSize_ 1000    
      $cbr0 set interopt_ .07
      $ns_ at 0.0 "$cbr0 start"
      $ns_ at 4.0 "$cbr0 stop"
      
      set udp1 [$ns_ create-connection UDP $mnode_(13) LossMonitor $mnode_(22) 0]
      $udp1 set fid_ 1
      set cbr1 [$udp1 attach-app Traffic/CBR]
      $cbr1 set packetSize_ 1000    
      $cbr1 set interopt_ .07
      $ns_ at 0.1 "$cbr1 start"
      $ns_ at 4.1 "$cbr1 stop"
      
      
      set udp2 [$ns_ create-connection UDP $mnode_(11) LossMonitor $mnode_(20) 0]
      $udp2 set fid_ 1
      set cbr2 [$udp2 attach-app Traffic/CBR]
      $cbr2 set packetSize_ 1000    
      $cbr2 set interopt_ .07
      $ns_ at 2.4 "$cbr2 start"
      $ns_ at 4.1 "$cbr2 stop"
      
      set udp3 [$ns_ create-connection UDP $mnode_(2) LossMonitor $mnode_(15) 0]
      $udp3 set fid_ 1
      set cbr3 [$udp3 attach-app Traffic/CBR]
      $cbr3 set packetSize_ 1000    
      $cbr3 set interopt_ 5
      $ns_ at 4.0 "$cbr3 start"
      $ns_ at 4.1 "$cbr3 stop"
      
      set udp4 [$ns_ create-connection UDP $mnode_(14) LossMonitor $mnode_(14) 0]
      $udp4 set fid_ 1
      set cbr4 [$udp4 attach-app Traffic/CBR]
      $cbr4 set packetSize_ 1000    
      $cbr4 set interopt_ 5
      $ns_ at 4.0 "$cbr4 start"
      $ns_ at 4.1 "$cbr4 stop"
      
      set udp5 [$ns_ create-connection UDP $mnode_(15) LossMonitor $mnode_(16) 0]
      $udp5 set fid_ 1
      set cbr5 [$udp5 attach-app Traffic/CBR]
      $cbr5 set packetSize_ 1000    
      $cbr5 set interopt_ 5
      $ns_ at 4.0 "$cbr5 start"
      $ns_ at 4.1 "$cbr5 stop"
      
      set udp6 [$ns_ create-connection UDP $mnode_(15) LossMonitor $mnode_(17) 0]
      $udp6 set fid_ 1
      set cbr6 [$udp6 attach-app Traffic/CBR]
      $cbr6 set packetSize_ 1000    
      $cbr6 set interopt_ 5
      $ns_ at 4.0 "$cbr6 start"
      $ns_ at 4.1 "$cbr6 stop"
            
      set udp7 [$ns_ create-connection UDP $mnode_(14) LossMonitor $mnode_(4) 0]
      $udp7 set fid_ 1
      set cbr7 [$udp7 attach-app Traffic/CBR]
      $cbr7 set packetSize_ 1000    
      $cbr7 set interopt_ 5
      $ns_ at 4.0 "$cbr7 start"
      $ns_ at 4.1 "$cbr7 stop"
      
      set udp8 [$ns_ create-connection UDP $mnode_(14) LossMonitor $mnode_(9) 0]
      $udp8 set fid_ 1
      set cbr8 [$udp8 attach-app Traffic/CBR]
      $cbr8 set packetSize_ 1000    
      $cbr8 set interopt_ 5
      $ns_ at 4.0 "$cbr8 start"
      $ns_ at 4.1 "$cbr8 stop"
      
      set udp9 [$ns_ create-connection UDP $mnode_(4) LossMonitor $mnode_(3) 0]
      $udp9 set fid_ 1
      set cbr9 [$udp9 attach-app Traffic/CBR]
      $cbr9 set packetSize_ 1000    
      $cbr9 set interopt_ 5
      $ns_ at 4.0 "$cbr9 start"
      $ns_ at 4.1 "$cbr9 stop"
      
      set udp10 [$ns_ create-connection UDP $mnode_(4) LossMonitor $mnode_(12) 0]
      $udp10 set fid_ 1
      set cbr10 [$udp10 attach-app Traffic/CBR]
      $cbr10 set packetSize_ 1000   
      $cbr10 set interopt_ 5
      $ns_ at 4.0 "$cbr10 start"
      $ns_ at 4.1 "$cbr10 stop"
      
      set udp11 [$ns_ create-connection UDP $mnode_(9) LossMonitor $mnode_(11) 0]
      $udp11 set fid_ 1
      set cbr11 [$udp11 attach-app Traffic/CBR]
      $cbr11 set packetSize_ 1000   
      $cbr11 set interopt_ 5
      $ns_ at 4.0 "$cbr11 start"
      $ns_ at 4.1 "$cbr11 stop"
      
      set udp12 [$ns_ create-connection UDP $mnode_(9) LossMonitor $mnode_(10) 0]
      $udp12 set fid_ 1
      set cbr12 [$udp12 attach-app Traffic/CBR]
      $cbr12 set packetSize_ 1000   
      $cbr12 set interopt_ 5
      $ns_ at 4.0 "$cbr12 start"
      $ns_ at 4.1 "$cbr12 stop"

      

      proc stop {} {
            
                        global ns_ tracefd
                        $ns_ flush-trace
                        close $tracefd
                        #exec nam aodv.nam &            
                        exit 0

                   }

      puts "Starting Simulation........"
      $ns_ at 10.0 "stop"
      $ns_ run
           


