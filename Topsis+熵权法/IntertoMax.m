function [Interx] = IntertoMax(x,a,b)
    r = size(x, 1);
    Max = max([a - min(x),max(x) - b]);
    Interx = zeros(r, 1);
    for i = 1:r
        if x(i) < a
           Interx(i) = 1-(a-x(i))/Max;
        elseif x(i) > b
           Interx(i) = 1-(x(i)-b)/Max;
        else
           Interx(i) = 1;
        end
    end
end