function time=calculation_3smoke(cast_time,explode_time,explode_time1,explode_time2,velocity_smoke_x,velocity_smoke_y,interval1,interval2)
    %{
    输入参数
    %}
    global distance_x1 distance_y1 distance_z1;
    global distance_smoke_x distance_smoke_y distance_smoke_z;
    global velocity_missle_x1 velocity_missle_y1 velocity_missle_z1;


    start_time=cast_time+explode_time;
    end_time=min(67,max(max(cast_time+explode_time+20,cast_time+interval1+explode_time1),cast_time+interval1+interval2+explode_time2));
%{
速度常数计算
%}


    [~,start1,end1]=multi_return_calculation(cast_time,explode_time,velocity_smoke_x,velocity_smoke_y);
    [~,start2,end2]=multi_return_calculation(cast_time+interval1,explode_time1,velocity_smoke_x,velocity_smoke_y);
    [~,start3,end3]=multi_return_calculation(cast_time+interval1+interval2,explode_time2,velocity_smoke_x,velocity_smoke_y);


    time=0;
    for t=start_time:0.005:end_time
        if (t>=start1&&t<end1)||(t>=start2&&t<end2)||(t>=start3&&t<end3)
            time=time+0.005;
        end
    end
end