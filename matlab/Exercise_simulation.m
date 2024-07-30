% Solving the 2-D heat equation by the Finite Difference Method (FDM) using
% a barebones iterative scheme.
close all
clear
clc

% domain size and discretization steps
nx=60;                          % Number of grid points in space(x)
ny=60;                          % Number of grid points in space(y)
dx=1;                           % Distance between grid points(x)
dy=1;                           % Distance between grid points(y)
dt = 0.25;                       % Time step, for simplicity the thermal diffusivity has been merged with dt.

% other settings
plot_interval = 50;             % update the plot every this many iterations
niter=10000;                    % Number of iterations

% Initialize the temperature field
u_np1=ones(ny,nx)*10;           % temperature at time step n+1
u_n=ones(ny,nx)*10;             % temperature at time step n

mask = ones(60,60);
mask(8:22,23:37)=0;
mask(38:52,23:37)=0;
% Iterative scheme with forward differences in time and central differences
% in space.
j=2:nx-1;
i=2:ny-1;
for it=1:niter
    % Update the temperature in the current time step
    u_np1(i,j) = u_n(i,j) + dt*((u_n(i+1,j)-2*u_n(i,j)+u_n(i-1,j))/(dx^2) + (u_n(i,j+1)-2*u_n(i,j)+u_n(i,j-1))/(dy^2));
    
    % Enforce boundary conditions
    % Constant temperature (Dirichlet boundary condition)
    %u_np1(10:20,25:35)=25;      % top heat sink in the center
    %u_np1(40:50,25:35)=25;      % bottom heat sink in the center
    %u_np1(1,:) = 400;             % left side
    %u_np1(nx,:) = 400;          % right side
    u_np1(:,nx) = u_np1(:,nx-1) + 2;
    u_np1(:,1) = u_np1(:,2);
    % No flux boundary conditions (Neumann conditions)
    %u_np1(:,1)=u_np1(:,2);      % no flux boundary condition
    %u_np1(:,ny)=u_np1(:,ny-1);  % no flux boundary condition
    
    u_np1(1,:)=u_np1(2,:);      % no flux boundary condition
    u_np1(ny,:)=u_np1(ny-1,:);  % no flux boundary condition
    
    % plotting and printing
    if mod(it,plot_interval) == 0
        figure(1), imagesc(u_np1), colorbar, axis image
        title(sprintf('Temperature [°C] iter %5.0f',it))
        pause(0.1)
        
        % print the temperature at a specific location to the Command Window
        fprintf('Temperature at iteration %5.0f is %3.2f °C\n',it,u_np1(30,30))
    end
    
    % set the current time step to the previous time step
    
    
    lap = del2(u_np1) .* mask;
    if max(abs(lap),[],"all") < 0.05
        break;
    end
    
    u_n=u_np1;
end

% plot the heat flux in the steady state solution
[GX, GY] = gradient(u_np1);
gmag = sqrt(GX.^2+ GY.^2);
figure(2), imagesc(gmag), colorbar, axis image
title('Heat flux')

% plot the divergence of the gradient
lap = del2(u_np1);
lap(lap > 0.5) = 0.5;
lap(lap < -0.5) = -0.5;
figure(3), imagesc(lap), colorbar, axis image
title('\nabla^2 u')