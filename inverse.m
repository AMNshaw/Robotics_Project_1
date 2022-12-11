clear;clc;close all;

input_availible = 0;
while input_availible == 0
    prompt = "Input a 4 by 4 transformation matrix T: \n";
    T = input(prompt);
    if(size(T, 1) == size(T, 2 && size(T, 1) == 4))
        input_availible = 1;
    end
end

%     0.3129   -0.7773    0.5458    4.2475
%     0.7773    0.5398    0.3231    8.3301
%    -0.5458    0.3231    0.7731   18.7939
%          0         0         0    1.0000
n = T(1:3, 1);
o = T(1:3, 2);
a = T(1:3, 3);
p = T(1:3, 4);

theta2 = zeros(8, 1);
theta1 = zeros(8, 1);
theta4 = zeros(8, 1);
theta5 = zeros(8, 1);
theta6 = zeros(8, 1);
d_3 = zeros(2, 1);

theta2(1) = atan2(sqrt(p(1)^2 + p(2)^2 - 6.375^2), p(3));
theta2(2) = atan2(-sqrt(p(1)^2 + p(2)^2 - 6.375^2), p(3));
theta2(3) = atan2(sqrt(p(1)^2 + p(2)^2 - 6.375^2), p(3)) - pi;
theta2(4) = atan2(-sqrt(p(1)^2 + p(2)^2 - 6.375^2), p(3)) + pi;

for i = 1:4
    theta2(i+4) = theta2(i);
end

for i = 1:4
    d_3(i) = p(3)/cos(theta2(i));
    theta1(i) = atan2(d_3(i)*sin(theta2(i)), 6.375) - atan2(p(1), p(2));
    d_3(i+4) = d_3(i);
    theta1(i+4) = theta1(i);
end

for i = 1:4
    theta4(i) = atan2((-sin(theta1(i))*a(1) + cos(theta1(i))*a(2)), (cos(theta1(i))*cos(theta2(i))*a(1) + cos(theta2(i))*sin(theta1(i))*a(2) - sin(theta2(i))*a(3)));
    if(theta4(i) > 0)
        theta4(i + 4) = theta4(i) - pi;
    else
        theta4(i + 4) = theta4(i) + pi;
    end
end

for i = 1:8
      theta5(i) = atan2( (cos(theta1(i))*cos(theta2(i))*cos(theta4(i)) - sin(theta1(i))*sin(theta4(i)))*a(1) + (cos(theta1(i))*sin(theta4(i)) + cos(theta2(i))*cos(theta4(i))*sin(theta1(i)))*a(2) -cos(theta4(i))*sin(theta2(i))*a(3) ...
          , cos(theta1(i))*sin(theta2(i))*a(1) + sin(theta1(i))*sin(theta2(i))*a(2)+cos(theta2(i))*a(3));
end

for i = 1:4
 theta6(i) = atan2(cos(theta1(i))*sin(theta2(i))*o(1) + sin(theta1(i))*sin(theta2(i))*o(2) + cos(theta2(i))*o(3) ...
                   ,-(cos(theta1(i))*sin(theta2(i))*n(1) + sin(theta1(i))*sin(theta2(i))*n(2) + cos(theta2(i))*n(3)));
    if theta6(i) > 0
        theta6(i+4) = theta6(i) - pi;
    else
        theta6(i+4) = theta6(i) + pi;
    end
end



for i = 1:8
    fprintf("\nSolution %i: \n", i);
    fprintf("%f, %f, %f, %f, %f, %f \n", theta1(i)* 180/pi, theta2(i)* 180/pi, d_3(i), theta4(i)* 180/pi, theta5(i)* 180/pi, theta6(i)* 180/pi);
    if abs(theta1(i)) > 160 * pi/180
        fprintf("θ_1 out of range !\n");
        input_availible = 0;
    end
    if abs(theta2(i)) > 125 * pi/180
        fprintf("θ_2 out of range !\n");
        input_availible = 0;
    end
    if abs(d_3(i)) > 30
        fprintf("d_3 out of range !\n");
        input_availible = 0;
    end
    if abs(theta4(i)) > 140 * pi/180
        fprintf("θ_4 out of range !\n");
        input_availible = 0;
    end
    if abs(theta5(i)) > 100 * pi/180
        fprintf("θ_5 out of range !\n");
        input_availible = 0;
    end
    if abs(theta6(i)) > 260 * pi/180
        fprintf("θ_6 out of range !\n");
        input_availible = 0;
    end
end
fprintf("\n");


