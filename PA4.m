%% ---[ 2D Laplace Solver Via Iteration ) ]---
%   Finite Difference Modeling of the Laplace Equation
%
%   Author: Ragini Bakshi, Feb 2021

set(0,'DefaultFigureWindowStyle','docked')
set(0, 'defaultaxesfontsize', 12)
set(0, 'defaultaxesfontname', 'Times New Roman')
set(0, 'DefaultLineLineWidth',2);

clear all
close all

% Part 2
nx = 100;           %rows
ny = 100;           %columns
ni = 10000;         %number of steps 
V = zeros(nx,ny);

V(:,1) = 1;         %left boundary = 1
V(:,ny) = 1;        %right boundary = 1

for k = 1:ni
    for i = 2:nx-1
        for j = 2:ny-1
            if(i==1 & j>1 & j<ny)
                V(i, j) = (V(i+1,j)+V(i,j+1)+V(i,j-1))/3;
            % Top Edge: impacted by 3 particles around it
            elseif(i==nx & j>1 & j<ny)
                V(i,j)=(V(i-1,j)+V(i,j+1)+V(i,j-1))/3;
            % Finite Difference Formula
            else         
                V(i, j) = ( V(i+1, j) + V(i-1,j) + V(i,j+1) + V(i,j-1) ) / 4;
            end
        end
    end
     
    %Update plot every 50 steps
    if mod(k,50) == 0
        figure(1)
        surf(V)
        title('Part 2: Voltage Finite Difference Modeling')
        xlabel('Rows');
        ylabel('Columns');
        zlabel('Voltage (V)');
        pause(0.05)
    end
end
  
[Ex,Ey] = gradient(V);  %Electric field of gradient
    
figure(2)
quiver(-Ey', -Ex',10)
title('Part 2: Electric Field');

%% Image Filtering for Part 2
filtered = imboxfilt(V,3);
figure(3)
surf(filtered);
title('Image Filtered Voltage (Fixed Boundary Conditions)');
xlabel('Rows'); 
ylabel('Columns'); 
zlabel('Voltage (V)');

%% Insulating Sides: Part 1
ni = 10000;         %number of steps
V1 = zeros(nx,ny);
V1(:,1) = 1;         %left boundary = 1
V1(:,ny) = 0;        %right boundary = 0

for r = 1:ni
    for n = 1:nx
        for m = 1:ny
            % Left Edge: V = 1 here
            if(m==1)
                V1(n,m) = 1;
            % Right Edge: V = 0 here
            elseif(m == ny)
                V1(n,m) = 0;            
            % Bottom Edge: impacted by 3 particles around it
            elseif(n==1)
                 V1(n, m) = (V1(n+1,m)+V1(n,m+1)+V1(n,m-1))/3;
            % Top Edge: impacted by 3 particles around it
            elseif(n==nx)
                V1(n,m)=(V1(n-1,m)+V1(n,m+1)+V1(n,m-1))/3; 
            % Finite Difference Formula  
            else
                V1(n, m) = ( V1(n+1, m) + V1(n-1,m) + V1(n,m+1) + V1(n,m-1) ) / 4; 
            end
        end
    end
 
    % Update plot every 50 steps
    if mod(r,50) == 0
        figure(4)
        surf(V1)
        title('Part 1: Voltage Finite Difference Modeling for Insulating Sides')
        xlabel('Rows');
        ylabel('Columns');
        zlabel('Voltage (V)');
        pause(0.05)
    end
end
  
[Ex1,Ey1] = gradient(V1);  % Electric field of gradient
    
figure(5)
quiver(-Ey1', -Ex1',1)
title('Part 1: Electric Field for Insulating Sides');

%% Image Filtering for Part 1
filtered1 = imboxfilt(V1,3);
figure(6)
surf(filtered1);
title('Part 1: Image Filtered Voltage for Insulating Sides');
xlabel('Rows'); 
ylabel('Columns'); 
zlabel('Voltage (V)');

