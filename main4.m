clc;clear;
pi=3.14159265358979;
%{
输入参数
%}

           
%{
cast_time=1.5;
explode_time=3.6;
velocity_smoke_x=120;
velocity_smoke_y=0;
start_time=cast_time+explode_time;
end_time=min(67,cast_time+explode_time+20);
%}
%{
速度常数计算
%}
global distance_x1;global distance_y1;global distance_z1;
global distance_x2;global distance_y2;global distance_z2;
global distance_x3;global distance_y3;global distance_z3;
global distance_smoke_x;global distance_smoke_y;global distance_smoke_z;
global distance_smoke_x1;global distance_smoke_y1;global distance_smoke_z1;
global distance_smoke_x2;global distance_smoke_y2;global distance_smoke_z2;
global velocity_missle_x1;global velocity_missle_y1;global velocity_missle_z1;
global velocity_missle_x2;global velocity_missle_y2;global velocity_missle_z2;
global velocity_missle_x3;global velocity_missle_y3;global velocity_missle_z3;



distance_x1=20000;distance_y1=0;distance_z1=2000;
distance_x2=19000;distance_y2=600;distance_z2=2100;
distance_x3=6000;distance_y3=-3000;distance_z3=700;
distance_smoke_x=17800;distance_smoke_y=0;distance_smoke_z=1800;
distance_smoke_x1=12000;distance_smoke_y1=1400;distance_smoke_z1=1400;
distance_smoke_x2=6000;distance_smoke_y2=-3000;distance_smoke_z2=700;

[velocity_missle_x1,velocity_missle_y1,velocity_missle_z1]=constant_calculation(distance_x1,distance_y1,distance_z1);

[velocity_missle_x2,velocity_missle_y2,velocity_missle_z2]=constant_calculation(distance_x2,distance_y2,distance_z2);

[velocity_missle_x3,velocity_missle_y3,velocity_missle_z3]=constant_calculation(distance_x3,distance_y3,distance_z3);




primal_time=0;
alpha=0.3;
step=10^(-3);
w = 0.9;            
weight_min = 0.4;        
weight_max = 0.9;        
c1 = 2.0;           
c2 = 2.0;   
size=100;
max_echo=10^(5);

cast_time=rand(size,1)*3;
cast_time1=rand(size,1)*3;
cast_time2=rand(size,1)*3;
explode_time=rand(size,1).*10;
explode_time1=rand(size,1).*10;
explode_time2=rand(size,1).*10;
velocity=rand(size,1).*70.+70;
angle=-rand(size,1).*180;
velocity1=rand(size,1).*70.+70;
angle1=-rand(size,1).*180;
velocity2=rand(size,1).*70.+70;
angle2=-rand(size,1).*180;



cast_time_best=cast_time;
cast_time1_best=cast_time1;
cast_time2_best=cast_time2;
explode_time_best=explode_time;
explode_time1_best=explode_time1;
explode_time2_best=explode_time2;
velocity_best=velocity;
angle_best=angle;
velocity1_best=velocity1;
angle1_best=angle1;
velocity2_best=velocity2;
angle2_best=angle2;


velocity_smoke_x=velocity.*cos(angle./180.*pi);
velocity_smoke_y=velocity.*sin(angle./180.*pi);
velocity1_smoke_x=velocity1.*cos(angle1./180.*pi);
velocity1_smoke_y=velocity1.*sin(angle1./180.*pi);
velocity2_smoke_x=velocity2.*cos(angle2./180.*pi);
velocity2_smoke_y=velocity2.*sin(angle2./180.*pi);
time_best=arrayfun(@(i) calculation_3plane(cast_time(i,1),explode_time(i,1),explode_time1(i,1),explode_time2(i,1),velocity_smoke_x(i,1),velocity_smoke_y(i,1),cast_interval1(i,1),cast_interval2(i,1)),1:size)';

[all_time_best, all_best_idx] = max(time_best);
all_cast_time_best = cast_time(all_best_idx, 1);
all_explode_time_best = explode_time(all_best_idx, 1);
all_explode_time1_best = explode_time1(all_best_idx, 1);
all_explode_time2_best = explode_time2(all_best_idx, 1);
all_velocity_best = velocity(all_best_idx, 1);
all_angle_best = angle(all_best_idx, 1);
all_cast_interval1_best=cast_interval1_best(all_best_idx,1);
all_cast_interval2_best=cast_interval2_best(all_best_idx,1);

cast_time_v=zeros(size,1);
explode_time_v=zeros(size,1);
explode_time1_v=zeros(size,1);
explode_time2_v=zeros(size,1);
velocity_v=zeros(size,1);
angle_v=zeros(size,1);
cast_interval1_v=zeros(size,1);
cast_interval2_v=zeros(size,1);

cast_time_max=0.2;
explode_time_max=1;
explode_time1_max=1;
explode_time2_max=2;
velocity_max=0;
angle_max=0.2;
cast_interval1_max=0.4;
cast_interval2_max=0.4;

for echo=0:1:max_echo
    w = weight_max - (weight_max - weight_min) * echo / max_echo;
    for i=1:size
         cast_r1 = rand();
         cast_r2 = rand();
         explode_r1 = rand();
         explode_r2 = rand();
         explode1_r1 = rand();
         explode1_r2 = rand();
         explode2_r1 = rand();
         explode2_r2 = rand();
         v_r1 = rand();
         v_r2 = rand();
         a_r1 = rand();
         a_r2 = rand();
         cast_interval1_r1=rand();
         cast_interval1_r2=rand();
         cast_interval2_r1=rand();
         cast_interval2_r2=rand();



         cast_time_v(i,1) = w * cast_time_v(i,1) + c1*cast_r1.* (cast_time_best(i,1) - cast_time(i,1)) + c2 * cast_r2 .* (all_cast_time_best - cast_time(i,1));
         explode_time_v(i,1) = w * explode_time_v(i,1) + c1*explode_r1.* (explode_time_best(i,1) - explode_time(i,1)) + c2 * explode_r2 .* (all_explode_time_best - explode_time(i,1));
         explode_time1_v(i,1) = w * explode_time1_v(i,1) + c1*explode1_r1.* (explode_time1_best(i,1) - explode_time1(i,1)) + c2 * explode1_r2 .* (all_explode_time1_best - explode_time1(i,1));
         explode_time2_v(i,1) = w * explode_time2_v(i,1) + c1*explode2_r1.* (explode_time2_best(i,1) - explode_time2(i,1)) + c2 * explode2_r2 .* (all_explode_time2_best - explode_time2(i,1));
         velocity_v(i,1) = w * velocity_v(i,1) + c1*v_r1.* (velocity_best(i,1) - velocity(i,1)) + c2 * v_r2 .* (all_velocity_best - velocity(i,1));
         angle_v(i,1) = w * angle_v(i,1) + c1*a_r1.* (angle_best(i,1) - angle(i,1)) + c2 * a_r2 .* (all_angle_best - angle(i,1));
         cast_interval1_v(i,1) = w * cast_interval1_v(i,1) + c1*cast_interval1_r1.* (cast_interval1_best(i,1) - cast_interval1(i,1)) + c2 * cast_interval1_r2 .* (all_cast_interval1_best - cast_interval1(i,1));
         cast_interval2_v(i,1) = w * cast_interval2_v(i,1) + c1*cast_interval2_r1.* (cast_interval2_best(i,1) - cast_interval2(i,1)) + c2 * cast_interval2_r2 .* (all_cast_interval2_best - cast_interval2(i,1));

         cast_time_v(i,1)= min(max(cast_time_v(i,1), -cast_time_max), cast_time_max);
         explode_time_v(i,1)= min(max(explode_time_v(i,1), -explode_time_max), explode_time_max);
         explode_time1_v(i,1)= min(max(explode_time1_v(i,1), -explode_time1_max), explode_time1_max);
         explode_time2_v(i,1)= min(max(explode_time2_v(i,1), -explode_time2_max), explode_time2_max);
         velocity_v(i,1)= min(max(velocity_v(i,1), -velocity_max), velocity_max);
         angle_v(i,1)= min(max(angle_v(i,1), -angle_max), angle_max);
         cast_interval1_v(i,1)= min(max(cast_interval1_v(i,1), -cast_interval1_max), cast_interval1_max);
         cast_interval2_v(i,1)= min(max(cast_interval2_v(i,1), -cast_interval2_max), cast_interval2_max);

         cast_time(i,1) = cast_time(i,1) + cast_time_v(i,1);
         explode_time(i,1) = explode_time(i,1) + explode_time_v(i,1);
         explode_time1(i,1) = explode_time1(i,1) + explode_time1_v(i,1);
         explode_time2(i,1) = explode_time2(i,1) + explode_time2_v(i,1);
         velocity(i,1) = velocity(i,1) + velocity_v(i,1);
         angle(i,1) = angle(i,1) + angle_v(i,1);
         cast_interval1(i,1) = cast_interval1(i,1) + cast_interval1_v(i,1);
         cast_interval2(i,1) = cast_interval2(i,1) + cast_interval2_v(i,1);

         cast_time(i,1) = min(max(cast_time(i,1), 0), 1);
         explode_time(i,1) = min(max(explode_time(i,1), 0), 5);
         explode_time1(i,1) = min(max(explode_time1(i,1), 0), 5);
         explode_time2(i,1) = min(max(explode_time2(i,1), 0), 10);
         velocity(i,1) = min(max(velocity(i,1), 140), 140);
         angle(i,1) = min(max(angle(i,1), -1), 0);
         cast_interval1(i,1) = min(max(cast_interval1(i,1), 1), 3);
         cast_interval2(i,1) = min(max(cast_interval2(i,1), 1), 3);
 
         velocity_smoke_x(i,1)=velocity(i,1)*cos(angle(i,1)/180*pi);
         velocity_smoke_y(i,1)=velocity(i,1)*sin(angle(i,1)/180*pi);
         time_tochoose=calculation_3smoke(cast_time(i,1),explode_time(i,1),explode_time1(i,1),explode_time2(i,1),velocity_smoke_x(i,1),velocity_smoke_y(i,1),cast_interval1(i,1),cast_interval2(i,1));

         if time_tochoose>time_best(i,1)
            time_best(i,1)=time_tochoose;
            cast_time_best(i,1)=cast_time(i,1);
            explode_time_best(i,1)=explode_time(i,1);
            explode_time1_best(i,1)=explode_time1(i,1);
            explode_time2_best(i,1)=explode_time2(i,1);
            velocity_best(i,1)=velocity(i,1);
            angle_best(i,1)=angle(i,1);
            cast_interval1_best(i,1)=cast_interval1(i,1);
            cast_interval2_best(i,1)=cast_interval2(i,1);

            
            if time_tochoose>all_time_best
                all_time_best=time_tochoose;
                all_cast_time_best = cast_time(i, 1);
                all_explode_time_best = explode_time(i, 1);
                all_explode_time1_best = explode_time1(i, 1);
                all_explode_time2_best = explode_time2(i, 1);
                all_velocity_best = velocity(i, 1);
                all_angle_best = angle(i, 1);
                all_cast_interval1_best=cast_interval1(i,1);
                all_cast_interval2_best=cast_interval2(i,1);
            end
         end
    end

     if mod(echo, 100)==0
        all_time_best
        echo
     end
end

all_cast_time_best
all_explode_time_best 
all_velocity_best 
all_angle_best 