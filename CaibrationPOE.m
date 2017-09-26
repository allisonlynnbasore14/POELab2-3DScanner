%Distance = [60,55,50,45,40,35,30,25,20];
%Outputs = [255,260,285,307,335,385,425,520,565];
%plot(Outputs, Distances);
Distance = [55,50,45,40,35,30,25,20];

Outputs55 = [250,252,246,240,243,241,241,242,249];
Outputs50 = [261,263,264,266,267,273,276,262,263];
Outputs45 = [291,291,295,314,291,289,289,291,292];
Outputs40 = [334,318,321,320,319,325,327,315,318];
Outputs35 = [369,360,359,365,370,380,361,359,361];
Outputs30 = [408,406,414,409,405,407,412,422,409];
Outputs25 = [484,496,481,486,484,494,491,487,488];
Outputs20 = [512,524,523,538,554,539,544,547,540];
OutputsFinal = [mean(Outputs55), mean(Outputs50), mean(Outputs45),mean(Outputs40),mean(Outputs35),mean(Outputs30), mean(Outputs25), mean(Outputs20)]
plot(OutputsFinal, Distance);




