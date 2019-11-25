function pixels = Lvvtilde(inpic, shape)
 if (nargin < 2)
   shape = 'same';
 end

 dxmask = [0,1/2,0,-1/2,0];
 dymask = dxmask';
 dxy_mask = conv2(dxmask,dymask,'same');
 dxx_mask = conv2(dxmask,dxmask,'same');
 dyy_mask = conv2(dymask,dymask,'same');

 Lx = conv2(inpic,dxmask, shape);
 Ly = conv2(inpic,dymask, shape);
 Lxx = conv2(inpic,dxx_mask, shape);
 Lxy = conv2(inpic,dxy_mask, shape);
 Lyy = conv2(inpic,dyy_mask, shape); 

 pixels = (Lx.^2).*Lxx + 2.*Lx.*Ly.*Lxy + (Ly.^2).*Lyy;
end
