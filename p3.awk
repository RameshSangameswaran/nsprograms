BEGIN{
#include<stdio.h>
c=0;
}
{
if($1=="d") #d stands for the packets drops.
c++ ;
}
END{
printf("The Total no of Packets Dropped due to Congestion : %d\n", c);
}
