function pixels = Lv(inpic, shape)
 if (nargin < 2)
   shape = 'same';
 end
 % central used
 dxmask = [-1 0 1];
 dymask = dxmask';
 Lx = filter2(dxmask, inpic, shape);
 Ly = filter2(dymask, inpic, shape);
 pixels = sqrt(Ly.^2 + Lx.^2);
 

 