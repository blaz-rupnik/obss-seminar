function cannyEdgeDetector(image_name)
    % read image
    img = imread(image_name);
    % 1. NOISE REDUCTION
    img_smoothed = imgaussfilt(im2double(img), 2);
    %figure; imshow(img_smoothed, []); title('Gaussian smoothing');
    % 2. GRADIENT CALCULATION
    kx = [-1 0 1; -1 0 1; -1 0 1];
    ky = [-1 -1 -1; 0 0 0; 1 1 1];
    gx = conv2(img_smoothed, kx, 'same');
    gy = conv2(img_smoothed, ky, 'same');
    %figure; imshow(gx, []); title('Horizontal gradient');
    %figure; imshow(gy, []); title('Vertical gradient');
    mag = sqrt(gx.^2 + gy.^2);
    ang = atan2(gy, gx);
    %figure; imshow(mag, [min(mag(:)),max(mag(:))]); title('Magnitude');
    %figure; imshow(ang, [min(ang(:)),max(ang(:))]); title('Angle');
    % normalize angles
    ang = ang * 180/pi;
    % adjustment for negative directions
    length1 = size(img, 1);
    length2 = size(img, 2);
    negative = ang < 0;
    ang(negative) = 360 + ang(negative);
    ang = adjustAngle(ang, length1, length2);
    % 3. NON MAXIMA SUPPRESSION
    suppressed = nonMaximaSuppression(mag, ang, length1, length2);
    % figure; imshow(suppressed);
    %ang(200:205,200:205)
    % 4. HYSTERESIS THRESHOLDING AND 8-CONNECTIVITY FOR WEAK PIXELS
    T_Low = 0.05;
    T_High = 0.15;
    detected_edges = hysteresisThresholding(suppressed, length1, length2, T_Low, T_High);
    figure; imshow(detected_edges, [0, 255]);
end