function [result] = hysteresisThresholding(temp, length1, length2, T_low, T_high)
    result = zeros(length1, length2);
    for i = 1  : length1
        for j = 1 : length2
            if (temp(i, j) < T_low)
                result(i, j) = 0;
            elseif (temp(i, j) > T_high)
                result(i, j) = 1;
            elseif ( temp(i+1,j)>T_high || temp(i-1,j)>T_high || temp(i,j+1)>T_high || temp(i,j-1)>T_high || temp(i-1, j-1)>T_high || temp(i-1, j+1)>T_high || temp(i+1, j+1)>T_high || temp(i+1, j-1)>T_high)
                result(i,j) = 1;
            end
        end
    end
    result = uint8(result.*255);
end