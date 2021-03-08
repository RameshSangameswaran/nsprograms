set ns [new Simulator]
set trf [open p4.tr w]
$ns trace-all $trf
set naf [open p4.nam w]
$ns namtrace-all $naf
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
$n1 label "Source"
$n2 label "Error Node"
$n5 label "Destination"

$ns make-lan "$n0 $n1 $n2 $n3" 10Mb 10ms LL Queue/DropTail Mac/802_3
$ns make-lan "$n4 $n5 $n6" 10Mb 10ms LL Queue/DropTail Mac/802_3

$ns duplex-link $n2 $n6 10Mb 100ms DropTail
set udp0 [new Agent/UDP]
$ns attach-agent $n1 $udp0
set cbr0 [ new Application/Traffic/CBR]
$cbr0 attach-agent $udp0
set null5 [new Agent/Null]
$ns attach-agent $n5 $null5
$ns connect $udp0 $null5
$cbr0 set packetSize_ 100
$cbr0 set interval_ 0.001
$udp0 set class_ 1

set err [new ErrorModel]
$ns lossmodel $err $n2 $n6
$err set rate_ 0.1
proc finish { } {
global nf ns tf
exec nam p4.nam &
close $naf
close $trf
exit 0
}
$ns at 6.0 "finish"
$ns at 0.1 "$cbr0 start"
$ns run
