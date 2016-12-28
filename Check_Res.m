function [ res ] = Check_Res(a0,a1,a2,b0,b1,b2 )
    [eq, z] = two_equations();
    %a0 = 1;
    %a1 = 1;
    %a2 = 2;
    %b0 = 1;
    %b1 = 2;
    %b2 = 1;
    [x1, y1] = solver_two_equations(a0,a1,a2,b0,b1,b2);
    res = true;
    
    for a = eq
        for i = 1:length(x1)
            x = x1(i);
            y = y1(i);
            if (abs(eval(a))  < 1e-10)
                res = true;
            else
                res = false;
                return;
            end
        end
    end
         
end

