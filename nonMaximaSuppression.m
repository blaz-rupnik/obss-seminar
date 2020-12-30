function [result] = nonMaximaSuppression(magnitudes, angles, length1, length2)
    result = zeros(length1, length2);
    for i=2:length1-1
        for j=2:length2-1
            if (angles(i,j)==0)
                result(i,j) = (magnitudes(i,j) == max([magnitudes(i,j), magnitudes(i,j+1), magnitudes(i,j-1)]));
            elseif (angles(i,j)==45)
                result(i,j) = (magnitudes(i,j) == max([magnitudes(i,j), magnitudes(i+1,j-1), magnitudes(i-1,j+1)]));
            elseif (angles(i,j)==90)
                result(i,j) = (magnitudes(i,j) == max([magnitudes(i,j), magnitudes(i+1,j), magnitudes(i-1,j)]));
            elseif (angles(i,j)==135)
                result(i,j) = (magnitudes(i,j) == max([magnitudes(i,j), magnitudes(i+1,j+1), magnitudes(i-1,j-1)]));
            end
        end
    end
    result = result .* magnitudes;
end