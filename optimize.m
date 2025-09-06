function [all_time_best,all_start_time,all_end_time,all_cast_time_best,all_explode_time_best,all_velocity_best,all_angle_best]=optimize(distance_x1,distance_y1,distance_z1, ...
    distance_smoke_x,distance_smoke_y,distance_smoke_z, ...
    velocity_missle_x1,velocity_missle_y1,velocity_missle_z1)

   
    weight_min = 0.4;        
    weight_max = 0.9;        
    c1 = 2.0;           
    c2 = 2.0;   
    size=10;
    max_echo=10^(5);
    
    cast_time=rand(size,1)*60;
    explode_time=rand(size,1).*8;
    velocity=rand(size,1).*70.+70;
    angle=-rand(size,1).*180;
    
    cast_time_best=cast_time;
    explode_time_best=explode_time;
    velocity_best=velocity;
    angle_best=angle;
    velocity_smoke_x=velocity.*cos(angle./180.*pi);
    velocity_smoke_y=velocity.*sin(angle./180.*pi);
    time_best=arrayfun(@(i) getFirstOutput(cast_time(i,1),explode_time(i,1),velocity_smoke_x(i,1),velocity_smoke_y(i,1), ...
                                                       distance_x1,distance_y1,distance_z1, ...
                                                       distance_smoke_x,distance_smoke_y,distance_smoke_z, ...
                                                       velocity_missle_x1,velocity_missle_y1,velocity_missle_z1),1:size)';

    
    
    [all_time_best, all_best_idx] = max(time_best);
    all_cast_time_best = cast_time(all_best_idx, 1);
    all_explode_time_best = explode_time(all_best_idx, 1);
    all_velocity_best = velocity(all_best_idx, 1);
    all_angle_best = angle(all_best_idx, 1);
    

    
    cast_time_v=zeros(size,1);
    explode_time_v=zeros(size,1);
    velocity_v=zeros(size,1);
    angle_v=zeros(size,1);
    
    cast_time_max=12;
    explode_time_max=1.6;
    velocity_max=14;
    angle_max=72;
    
    for echo=0:1:max_echo
        w = weight_max - (weight_max - weight_min) * echo / max_echo;
        for i=1:size
             cast_r1 = rand();
             cast_r2 = rand();
             explode_r1 = rand();
             explode_r2 = rand();
             v_r1 = rand();
             v_r2 = rand();
             a_r1 = rand();
             a_r2 = rand();
             
    
             cast_time_v(i,1) = w * cast_time_v(i,1) + c1*cast_r1.* (cast_time_best(i,1) - cast_time(i,1)) + c2 * cast_r2 .* (all_cast_time_best - cast_time(i,1));
             explode_time_v(i,1) = w * explode_time_v(i,1) + c1*explode_r1.* (explode_time_best(i,1) - explode_time(i,1)) + c2 * explode_r2 .* (all_explode_time_best - explode_time(i,1));
             velocity_v(i,1) = w * velocity_v(i,1) + c1*v_r1.* (velocity_best(i,1) - velocity(i,1)) + c2 * v_r2 .* (all_velocity_best - velocity(i,1));
             angle_v(i,1) = w * angle_v(i,1) + c1*a_r1.* (angle_best(i,1) - angle(i,1)) + c2 * a_r2 .* (all_angle_best - angle(i,1));
              
             cast_time_v(i,1)= min(max(cast_time_v(i,1), -cast_time_max), cast_time_max);
             explode_time_v(i,1)= min(max(explode_time_v(i,1), -explode_time_max), explode_time_max);
             velocity_v(i,1)= min(max(velocity_v(i,1), -velocity_max), velocity_max);
             angle_v(i,1)= min(max(angle_v(i,1), -angle_max), angle_max);
    
             cast_time(i,1) = cast_time(i,1) + cast_time_v(i,1);
             explode_time(i,1) = explode_time(i,1) + explode_time_v(i,1);
             velocity(i,1) = velocity(i,1) + velocity_v(i,1);
             angle(i,1) = angle(i,1) + angle_v(i,1);
    
             cast_time(i,1) = min(max(cast_time(i,1), 0), 60);
             explode_time(i,1) = min(max(explode_time(i,1), 0), 8);
             velocity(i,1) = min(max(velocity(i,1), 70), 140);
             angle(i,1) = min(max(angle(i,1), -180), 0);
     
             velocity_smoke_x(i,1)=velocity(i,1)*cos(angle(i,1)/180*pi);
             velocity_smoke_y(i,1)=velocity(i,1)*sin(angle(i,1)/180*pi);
             [time_tochoose,start_time,end_time]=calculation(cast_time(i,1),explode_time(i,1),velocity_smoke_x(i,1),velocity_smoke_y(i,1), ...
                 distance_x1,distance_y1,distance_z1, ...
                 distance_smoke_x,distance_smoke_y,distance_smoke_z, ...
                 velocity_missle_x1,velocity_missle_y1,velocity_missle_z1);
    
             if time_tochoose>time_best(i,1)
                time_best(i,1)=time_tochoose;
                cast_time_best(i,1)=cast_time(i,1);
                explode_time_best(i,1)=explode_time(i,1);
                velocity_best(i,1)=velocity(i,1);
                angle_best(i,1)=angle(i,1);
                
                if time_tochoose>all_time_best
                    all_time_best=time_tochoose;
                    all_cast_time_best = cast_time(i, 1);
                    all_explode_time_best = explode_time(i, 1);
                    all_velocity_best = velocity(i, 1);
                    all_angle_best = angle(i, 1);
                    all_start_time=start_time;
                    all_end_time=end_time;
                end
             end
        end
    
         if mod(echo, 1000)==0
            all_time_best
            echo
            cast_time=rand(size,1)*60;
            explode_time=rand(size,1).*8;
            velocity=rand(size,1).*70.+70;
            angle=-rand(size,1).*180;
    
            cast_time_best=cast_time;
            explode_time_best=explode_time;
            velocity_best=velocity;
            angle_best=angle;
            velocity_smoke_x=velocity.*cos(angle./180.*pi);
            velocity_smoke_y=velocity.*sin(angle./180.*pi);
         end
    end
end