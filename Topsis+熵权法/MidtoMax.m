function [Midx] = MidtoMax(x, top)
    res = max(abs(x - top));
    Midx = 1 - abs(x - top) / res;
end

