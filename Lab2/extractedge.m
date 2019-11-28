function edgecurves = extractedge(inpic, scale, threshold, shape)

    if (nargin < 4) 
        shape = 'same';
    end

    lv = Lv(discgaussfft(inpic, scale), shape);
    lvv = Lvvtilde(discgaussfft(inpic, scale), shape);
    lvvv = Lvvvtilde(discgaussfft(inpic, scale), shape);
    lv_mask = (lv > threshold) - 0.5;
    lvvv_mask = (lvvv < 0) - 0.5;

    % sort zerocrossings with negative Lvvv and Lv above threshold
    edgecurves = zerocrosscurves(lvv, lvvv_mask);
    edgecurves = thresholdcurves(edgecurves, lv_mask);
    overlaycurves(inpic, edgecurves);

end

