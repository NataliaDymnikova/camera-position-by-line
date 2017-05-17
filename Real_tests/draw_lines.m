function [] = draw_lines(i, step, good_lines, lines)
    d = dir('cpp/Real_tests/rgbd_dataset_freiburg1_floor/rgb/*.png');
    if length(good_lines) == 0
        return;
    end
    img1 = imread(string(d(i).folder) + '\'+ d(i).name, 'png');
    img2 = imread(string(d(i+step).folder) + '\'+ d(i+step).name, 'png');
    img3 = imread(string(d(i+2*step).folder) + '\'+ d(i+2*step).name, 'png');
        
    for j = 1:length(good_lines)
        k = good_lines(j);
        [p11,p12] = get_points(lines,k, 1:3);
        [p21,p22] = get_points(lines,k, 4:6);
        [p31,p32] = get_points(lines,k, 7:9);
        
        img1 = insertShape(img1, 'Line', [p11(1),p11(2), p12(1),p12(2)],'LineWidth',4,'Color','blue');
        img2 = insertShape(img2, 'Line', [p21(1),p21(2), p22(1),p22(2)],'LineWidth',4,'Color','blue');
        img3 = insertShape(img3, 'Line', [p31(1),p31(2), p32(1),p32(2)],'LineWidth',4,'Color','blue');
        
    end
    
    fig = figure(1);
    subplot(1,3,1), imshow(img1);
    subplot(1,3,2), imshow(img2);
    subplot(1,3,3), imshow(img3);

    name = strcat('.\plots\floor\', string(i),'.png');
    saveas(fig, char(name));

end

function [p1,p2] = get_points(lines, j, nums)
    l = lines(:,j);
    l = l(nums);
    fx = 517.3;
    fy = 516.5;
    cx = 318.6;
    cy = 255.3;

    if (l(2) ~= 0)
        x1 = 0;
        y1 = -l(3)/l(2);
        x2 = 640;
        y2 = (-l(3)-x2*l(1))/l(2);
    else
        y1 = 0;
        x1 = -l(3)/l(1);
        y2 = 640;
        x2 = (-l(3)-y2*l(2))/l(1);            
    end

    p1 = [x1,y1];
    p2 = [x2,y2];
  
 end