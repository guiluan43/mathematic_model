function [velocity_missle_x,velocity_missle_y,velocity_missle_z]=constant_calculation(distance_x,distance_y,distance_z)
    distance_missle=sqrt(distance_x^2+distance_y^2+distance_z^2);
    velocity_missle_x=300*distance_x/distance_missle;
    velocity_missle_y=300*distance_y/distance_missle;
    velocity_missle_z=300*distance_z/distance_missle;
end