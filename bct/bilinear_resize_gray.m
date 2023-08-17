function resized_image = bilinear_resize_gray(input_image, output_size)
    [rows, cols] = size(input_image);
    output_rows = output_size(1);
    output_cols = output_size(2);
    
    % Calculate the scaling factors
    row_scale = rows / output_rows;
    col_scale = cols / output_cols;
    
    % Create an empty array for the resized image
    resized_image = uint8(zeros(output_rows, output_cols));
    
    % Bilinear interpolation
    for row = 1:output_rows
        for col = 1:output_cols
            % Find the corresponding coordinates in the input image
            row_pos = row * row_scale;
            col_pos = col * col_scale;

            % Calculate the surrounding pixel indices
            row_top = floor(row_pos);
            col_left = floor(col_pos);
            row_bottom = row_top + 1;
            col_right = col_left + 1;

            % Boundary conditions
            row_top = max(1, row_top);
            col_left = max(1, col_left);
            row_bottom = min(rows, row_bottom);
            col_right = min(cols, col_right);

            % Interpolation weights
            weight_top = row_bottom - row_pos;
            weight_bottom = row_pos - row_top;
            weight_left = col_right - col_pos;
            weight_right = col_pos - col_left;

            % Bilinear interpolation
            pixel_value = weight_top * (input_image(row_top, col_left) * weight_left + input_image(row_top, col_right) * weight_right) ...
                        + weight_bottom * (input_image(row_bottom, col_left) * weight_left + input_image(row_bottom, col_right) * weight_right);
            resized_image(row, col) = round(pixel_value);
        end
    end
end
