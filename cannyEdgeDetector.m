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
    
end