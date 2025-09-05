function judge=determine(judge,distance_attimet_missle_x,distance_attimet_smoke_x,distance_attimet_missle_y,distance_attimet_smoke_y,distance_attimet_missle_z,distance_attimet_smoke_z,check1_x,check1_y,t)
    
    distance_between=sqrt((distance_attimet_missle_x-distance_attimet_smoke_x)^2+(distance_attimet_missle_y-distance_attimet_smoke_y)^2+(distance_attimet_missle_z-distance_attimet_smoke_z)^2);
    
    distance_between_check1=sqrt((distance_attimet_missle_x-check1_x)^2+(distance_attimet_missle_y-check1_y)^2+(distance_attimet_missle_z)^2);
    distance_between_check2=sqrt((distance_attimet_missle_x-check1_x)^2+(distance_attimet_missle_y-check1_y)^2+(distance_attimet_missle_z-10)^2);
    theta=asin(10/distance_between);
    theta1=acos(((distance_attimet_missle_x-distance_attimet_smoke_x)*(distance_attimet_missle_x-check1_x)+(distance_attimet_missle_y-distance_attimet_smoke_y)*(distance_attimet_missle_y-check1_y)+(distance_attimet_missle_z-distance_attimet_smoke_z)*(distance_attimet_missle_z))/(distance_between_check1*distance_between));
    theta2=acos(((distance_attimet_missle_x-distance_attimet_smoke_x)*(distance_attimet_missle_x-check1_x)+(distance_attimet_missle_y-distance_attimet_smoke_y)*(distance_attimet_missle_y-check1_y)+(distance_attimet_missle_z-distance_attimet_smoke_z)*(distance_attimet_missle_z-10))/(distance_between_check2*distance_between));
        if((theta<theta1 || theta<theta2)&&distance_between>10)
            judge=1;
        end

end