clear;clc;close all;

syms theta [1 6];
syms d_3;

input_availible = 0;

while input_availible == 0
    prompt = "Input [theta_1, theta_2, d_3, theta_4, theta_5, theta_6]: \n";
    param = input(prompt);
    input_availible = 1;

    if size(param, 2) == 6
        if abs(param(1)) > 160
            fprintf("θ_1 out of range !\n");
            input_availible = 0;
        end
        if abs(param(2)) > 125
            fprintf("θ_2 out of range !\n");
            input_availible = 0;
        end
        if abs(param(3)) > 30
            fprintf("d_3 out of range !\n");
            input_availible = 0;
        end
        if abs(param(4)) > 140
            fprintf("θ_4 out of range !\n");
            input_availible = 0;
        end
        if abs(param(5)) > 100
            fprintf("θ_5 out of range !\n");
            input_availible = 0;
        end
        if abs(param(6)) > 260
            fprintf("θ_6 out of range !\n");
            input_availible = 0;
        end
    else
        fprintf("Input size is not availible, please try again:\n")
    end
end

theta1 = param(1)*pi/180;
theta2 = param(2)*pi/180;
d_3 = param(3);
theta4 = param(4)*pi/180;
theta5 = param(5)*pi/180;
theta6 = param(6)*pi/180;


A_1 = [cos(theta1) 0 -sin(theta1) 0; 
       sin(theta1) 0 cos(theta1) 0;
       0 -1 0 0;
       0 0 0 1];
A_2 = [cos(theta2) 0 sin(theta2) 0; 
       sin(theta2) 0 -cos(theta2) 0; 
       0 1 0 6.375; 
       0 0 0 1];
A_3 = [1 0 0 0; 
       0 1 0 0; 
       0 0 1 d_3; 
       0 0 0 1];
A_4 = [cos(theta4) 0 -sin(theta4) 0; 
       sin(theta4) 0 cos(theta4) 0; 
       0 -1 0 0; 
       0 0 0 1];
A_5 = [cos(theta5) 0 sin(theta5) 0;
       sin(theta5) 0 -cos(theta5) 0;
       0 1 0 0;
       0 0 0 1];
A_6 = [cos(theta6) -sin(theta6) 0 0;
       sin(theta6) cos(theta6) 0 0;
       0 0 1 0;
       0 0 0 1];

T = A_1*A_2*A_3*A_4*A_5*A_6;

euler_phi = atan2(T(2, 3), T(1, 3));
euler_theta = acos(T(3, 3));
euler_psi = atan2(-T(2, 3), T(1, 3));

fprintf("\nn, o, a, p: ");
T
fprintf("(x, y, z, φ, θ, ψ):\n(%f, %f, %f, %f, %f, %f)\n\n", T(1, 4), T(2, 4), T(3, 4), euler_phi*180/pi, euler_theta*180/pi, euler_psi*180/pi);
