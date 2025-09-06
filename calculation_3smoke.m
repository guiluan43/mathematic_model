function [time,start0,end0]=calculation_3smoke(cast_time,explode_time,explode_time1,explode_time2,velocity_smoke_x,velocity_smoke_y,interval1,interval2, ...
    distance_x1,distance_y1,distance_z1,...
    distance_smoke_x,distance_smoke_y,distance_smoke_z,...
    velocity_missle_x1,velocity_missle_y1,velocity_missle_z1)
    %{
    输入参数
    %}
    


    start_time=cast_time+explode_time;
    end_time=min(67,max(max(cast_time+explode_time+20,cast_time+interval1+explode_time1),cast_time+interval1+interval2+explode_time2));
%{
速度常数计算
%}


    [~,start1,end1]=calculation(cast_time,explode_time,velocity_smoke_x,velocity_smoke_y, ...
                                distance_x1,distance_y1,distance_z1, ...
                                distance_smoke_x,distance_smoke_y,distance_smoke_z, ...
                                velocity_missle_x1,velocity_missle_y1,velocity_missle_z1);
    [~,start2,end2]=calculation(cast_time+interval1,explode_time1,velocity_smoke_x,velocity_smoke_y, ...
                                distance_x1,distance_y1,distance_z1, ...
                                distance_smoke_x,distance_smoke_y,distance_smoke_z, ...
                                velocity_missle_x1,velocity_missle_y1,velocity_missle_z1);
    [~,start3,end3]=calculation(cast_time+interval1+interval2,explode_time2,velocity_smoke_x,velocity_smoke_y, ...
                                distance_x1,distance_y1,distance_z1, ...
                                distance_smoke_x,distance_smoke_y,distance_smoke_z, ...
                                velocity_missle_x1,velocity_missle_y1,velocity_missle_z1);


    time=0;
    start0=0;
    end0=0;
    for t=start_time:0.001:end_time
        if (t>=start1&&t<end1)||(t>=start2&&t<end2)||(t>=start3&&t<end3)
            if(start0==0)
                start0=t;
            end
            end0=t;
            time=time+0.001;
        end
    end
end