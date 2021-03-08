BEGIN{
 #include <stdio.h>
 pkt=0;
 time=0
}
{
 if($1=="r" && $3=="2" && $4=="6")
 {
 pkt=pkt+$6
 time=$2
 }
}
END{
 printf(" Throughput: %fMbps\n\n",(pkt/time)*(8/1000000));
}
