tools = few256;
deltax = [-1 0 1];
deltay = deltax';
dxtools = conv2(tools, deltax, 'valid');
dytools = conv2(tools, deltay, 'valid');
figure('name', 'Simple Difference Operator')
subplot(1,2,1)
showgrey(dxtools);
title('x direction');
subplot(1,2,2)
showgrey(dytools);
title('y direction');