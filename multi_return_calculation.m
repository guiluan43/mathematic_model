function [time,start_judge,end_judge]=multi_return_calculation(cast_time,explode_time,velocity_smoke_x,velocity_smoke_y)
%{
输入参数
%}
    global distance_x1 distance_y1 distance_z1;
    global distance_x2 distance_y2 distance_z2;
    global distance_x3 distance_y3 distance_z3;
    global distance_smoke_x distance_smoke_y distance_smoke_z;
    global velocity_missle_x1 velocity_missle_y1 velocity_missle_z1;
    global velocity_missle_x2 velocity_missle_y2 velocity_missle_z2;
    global velocity_missle_x3 velocity_missle_y3 velocity_missle_z3; 


    start_time=cast_time+explode_time;
    end_time=min(67,cast_time+explode_time+20);
%{
速度常数计算
%}


    start_judge=end_time;
    end_judge=end_time;
    time_judge=0;

    for t=start_time:0.01:end_time
    %{
    烟雾弹位置
    %}
        distance_attimet_smoke_x1=distance_smoke_x-velocity_smoke_x*(cast_time+explode_time);
        distance_attimet_smoke_y1=distance_smoke_y-velocity_smoke_y*(cast_time+explode_time);
        distance_attimet_smoke_z1=distance_smoke_z-1/2*9.8*explode_time^2-3*(t-cast_time-explode_time);

    %{
    导弹位置
    %}
        distance_attimet_missle_x1=distance_x1-velocity_missle_x1*t;
        distance_attimet_missle_y1=distance_y1-velocity_missle_y1*t;
        distance_attimet_missle_z1=distance_z1-velocity_missle_z1*t;
    %{
        distance_attimet_missle_x2=distance_x2-velocity_missle_x2*t;
        distance_attimet_missle_y2=distance_y2-velocity_missle_y2*t;
        distance_attimet_missle_z2=distance_z2-velocity_missle_z2*t;

        distance_attimet_missle_x3=distance_x3-velocity_missle_x3*t;
        distance_attimet_missle_y3=distance_y3-velocity_missle_y3*t;
        distance_attimet_missle_z3=distance_z3-velocity_missle_z3*t;
    %}
       

%{
近似计算8个点
%}
%{
检验夹角
%}
    distanceproject_attimet_missle_tofake=sqrt(distance_attimet_missle_x1^2+(distance_attimet_missle_y1-200)^2);
    judge=0;
    check1_x=7*(distance_attimet_missle_y1-200)/distanceproject_attimet_missle_tofake;
    check1_y=-7*(distance_attimet_missle_x1)/distanceproject_attimet_missle_tofake+200;
    judge=determine(judge,distance_attimet_missle_x1,distance_attimet_smoke_x1,distance_attimet_missle_y1,distance_attimet_smoke_y1,distance_attimet_missle_z1,distance_attimet_smoke_z1,check1_x,check1_y,t);
    
    
    check1_x=-7*(distance_attimet_missle_y1-200)/distanceproject_attimet_missle_tofake;
    check1_y=7*(distance_attimet_missle_x1)/distanceproject_attimet_missle_tofake+200;
    judge=determine(judge,distance_attimet_missle_x1,distance_attimet_smoke_x1,distance_attimet_missle_y1,distance_attimet_smoke_y1,distance_attimet_missle_z1,distance_attimet_smoke_z1,check1_x,check1_y,t);
    

    check1_x=7*(distance_attimet_missle_x1)/distanceproject_attimet_missle_tofake;
    check1_y=7*(distance_attimet_missle_y1-200)/distanceproject_attimet_missle_tofake+200;

    
    judge=determine(judge,distance_attimet_missle_x1,distance_attimet_smoke_x1,distance_attimet_missle_y1,distance_attimet_smoke_y1,distance_attimet_missle_z1,distance_attimet_smoke_z1,check1_x,check1_y,t);
    
    

    check1_x=-7*(distance_attimet_missle_x1)/distanceproject_attimet_missle_tofake;
    check1_y=-7*(distance_attimet_missle_y1-200)/distanceproject_attimet_missle_tofake+200;

    judge=determine(judge,distance_attimet_missle_x1,distance_attimet_smoke_x1,distance_attimet_missle_y1,distance_attimet_smoke_y1,distance_attimet_missle_z1,distance_attimet_smoke_z1,check1_x,check1_y,t);
    

        if judge==0 && time_judge==0
            time_judge=1;
            start_judge=t;
        else 
            if judge==1&&time_judge==1
                end_judge=t;
                time_judge=2;
            end
        end
    end
    time=end_judge-start_judge;
end