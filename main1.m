clc;clear;
pi=3.14159265358979;
%{
输入参数
%}

           

cast_time=1.5;
explode_time=3.6;
velocity_smoke_x=120;
velocity_smoke_y=0;
start_time=cast_time+explode_time;
end_time=min(67,cast_time+explode_time+20);

%{
速度常数计算
%}



distance_x1=20000;distance_y1=0;distance_z1=2000;
distance_x2=19000;distance_y2=600;distance_z2=2100;
distance_x3=6000;distance_y3=-3000;distance_z3=700;
distance_smoke_x=17800;distance_smoke_y=0;distance_smoke_z=1800;

[velocity_missle_x1,velocity_missle_y1,velocity_missle_z1]=constant_calculation(distance_x1,distance_y1,distance_z1);

[velocity_missle_x2,velocity_missle_y2,velocity_missle_z2]=constant_calculation(distance_x2,distance_y2,distance_z2);

[velocity_missle_x3,velocity_missle_y3,velocity_missle_z3]=constant_calculation(distance_x3,distance_y3,distance_z3);

[time,start_judge,end_judge]=calculation(cast_time,explode_time,velocity_smoke_x,velocity_smoke_y, ...
    distance_x1,distance_y1,distance_z1, ...
    distance_smoke_x,distance_smoke_y,distance_smoke_z, ...
    velocity_missle_x1,velocity_missle_y1,velocity_missle_z1);

time