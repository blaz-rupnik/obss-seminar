function [result] = adjustAngle(angles, length1, length2)
    result = zeros(length1, length2);
    for i = 1 : length1
        for j = 1 : length2
            if ((angles(i, j) >= 0 ) && (angles(i, j) < 22.5) || (angles(i, j) >= 157.5) && (angles(i, j) < 202.5) || (angles(i, j) >= 337.5) && (angles(i, j) <= 360))
                result(i, j) = 0;
            elseif ((angles(i, j) >= 22.5) && (angles(i, j) < 67.5) || (angles(i, j) >= 202.5) && (angles(i, j) < 247.5))
                result(i, j) = 45;
            elseif ((angles(i, j) >= 67.5 && angles(i, j) < 112.5) || (angles(i, j) >= 247.5 && angles(i, j) < 292.5))
                result(i, j) = 90;
            elseif ((angles(i, j) >= 112.5 && angles(i, j) < 157.5) || (angles(i, j) >= 292.5 && angles(i, j) < 337.5))
                result(i, j) = 135;
            end
        end
    end
end