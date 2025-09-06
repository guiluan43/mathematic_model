clc;clear;
pi=3.14159265358979;
%{
输入参数
%}

           

%{
速度常数计算
%}

distance_x1=20000;distance_y1=0;distance_z1=2000;
distance_x2=19000;distance_y2=600;distance_z2=2100;
distance_x3=18000;distance_y3=-600;distance_z3=1900;
%distance_smoke_x=17800;distance_smoke_y=0;distance_smoke_z=1800;
%distance_smoke_x=12000;distance_smoke_y=1400;distance_smoke_z=1400;
%distance_smoke_x=6000;distance_smoke_y=-3000;distance_smoke_z=700;
%distance_smoke_x=11000;distance_smoke_y=2000;distance_smoke_z=1800;
distance_smoke_x=13000;distance_smoke_y=-2000;distance_smoke_z=1300;


[velocity_missle_x1,velocity_missle_y1,velocity_missle_z1]=constant_calculation(distance_x1,distance_y1,distance_z1);

[velocity_missle_x2,velocity_missle_y2,velocity_missle_z2]=constant_calculation(distance_x2,distance_y2,distance_z2);

[velocity_missle_x3,velocity_missle_y3,velocity_missle_z3]=constant_calculation(distance_x3,distance_y3,distance_z3);

time=optimize_3missle(distance_x1,distance_y1,distance_z1, ...
    distance_x2,distance_y2,distance_z2,...
    distance_x3,distance_y3,distance_z3,...
    distance_smoke_x,distance_smoke_y,distance_smoke_z, ...
    velocity_missle_x1,velocity_missle_y1,velocity_missle_z1,...
    velocity_missle_x2,velocity_missle_y2,velocity_missle_z2,...
    velocity_missle_x3,velocity_missle_y3,velocity_missle_z3);


