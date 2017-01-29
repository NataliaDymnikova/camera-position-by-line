function [ l ] = get_lines_from_camera(start, endl)
    l = [];
    for i = 1:3
        x1 = start(2*i-1);
        y1 = start(2*i);
        x2 = endl(2*i-1);
        y2 = endl(2*i);
        l = [l, [y2 - y1; x1 - x2; y1 * x2 - x1 * y2]];
    end
end

