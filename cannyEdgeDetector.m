function cannyEdgeDetector(image_name)
    % read image
    img = imread(image_name);
    figure;
    subplot(2, 2, 1); imshow(img); title('Original image')
    % 1. NOISE REDUCTION
    img_smoothed = imgaussfilt(im2double(img), 2);
    subplot(2, 2, 2); imshow(img_smoothed); title('Gaussian smoothing');
    % 2. GRADIENT CALCULATION
    kx = [-1 0 1; -1 0 1; -1 0 1];
    ky = [-1 -1 -1; 0 0 0; 1 1 1];
    gx = conv2(img_smoothed, kx, 'same');
    gy = conv2(img_smoothed, ky, 'same');
    mag = sqrt(gx.^2 + gy.^2);
    ang = atan2(gy, gx);
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
    subplot(2, 2, 3); imshow(suppressed); title('After Non-Maxima suppression');
    % 4. HYSTERESIS THRESHOLDING AND 8-CONNECTIVITY FOR WEAK PIXELS
    thresh = multithresh(img_smoothed);
    thresh_low = thresh / 2;
    detected_edges = hysteresisThresholding(suppressed, length1, length2, thresh, thresh_low);
    subplot(2, 2, 4); imshow(detected_edges); title('Detected edges');
end