P=[ 0 0
    .005 0
    .01 0
    .015 0
    .02 0
    .025 0
    .03 0
    .035 0
    .04 0
    .045 0
    .05 0
    .045 .0005
    .04 .001
    .035 .0015
    .03 .002
    .025 .0025
    .02 .003
    .015 .0035
    .01 .004
    .005 .0045
    0 .005].';

T =[1 2 21
   2 20 21
   2 3 20
   3 19 20
   3 4 19
   4 18 19
   4 5 18
   5 17 18
   5 6 17
   6 16 17
   6 7 16
   7 15 16
   7 8 15
   8 14 15
   8 9 14
   9 13 14
   9 10 13
   10 12 13
   10 11 12].';
E=[1 2
    2 3
    3 4
    4 5
    5 6
    6 7
    7 8
    8 9
    9 10
    10 11
    11 12
    12 13
    13 14
    14 15
    15 16
    16 17
    17 18
    18 19
    19 20
    20 21
    21 1].';

pdemesh(P,E,T);