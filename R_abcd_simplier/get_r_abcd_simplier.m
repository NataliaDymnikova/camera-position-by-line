function [ R ] = get_r_abcd_simplier( r11, r12, r13, r21, r22, r23 )
    R = [r11, r12, r13;
        r21, r22, r23;
        cross([r11,r12,r13], [r21, r22, r23])];
end