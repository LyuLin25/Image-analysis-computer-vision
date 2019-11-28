house = godthem256;
smooth1 = discgaussfft(house, 0.001);
smooth2 = discgaussfft(house, 0.01);
smooth3 = discgaussfft(house, 0.1);
smooth4 = discgaussfft(house, 1);
smooth5 = discgaussfft(house, 10);

figure;
subplot(2,3,1)
showgrey(house);
title('x direction');
subplot(1,2,2)
showgrey(dytools);
title('y direction');