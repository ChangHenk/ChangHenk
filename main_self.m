% 20171115
% Lin, Li-Gang
% Example: Underactuated Two-Wheeled Inverted Pendulum mobile robot 
% [KiKw: IEEE/ASME Mechatronics, 22(6): 2803-2808, 2017]
% SDRE control
% Main function

clear all
close all
clc

global Q R g resolution
global m_B m_W 
global l r d 
global I_1 I_2 I_3 
global K J 


%% simulating parameters
%  [ x   theta   psi   x_dot  theta_dot   psi_dot ]
%Q= diag([ 50  1  0.0000001  1  1   1 ]);
Q= diag([ 1  1  1  50  1   1 ]);%best
R= [1 0;0 1];
%resolution= 1e-3;
resolution= 0.001;
g= 9.8;     % gravity constant

%% system parameters
m_B =54;
m_W =6.5;
l =0.116;
r =0.2032;% 8 in to m = 0.2032m
d =0.69;
I_1= 3.25;
I_2= 0.919; 
%I_3= 4;  % as I_3 increases while fixing others, this value (4) would start causing C_6< 0
I_3= 2.542; % [KiKw: IEEE/ASME Mechatronics, 2017]
K= 0.66;  %?‡ªè¡Œé?æ¸¬
J= 0.13;

%%    X = [ x   x_dot  theta  theta_dot  psi   psi_dot ]
% x0 = [ -0.1      15*pi/180     0*pi/180       0.2         0*pi/180        480*pi/180  ]; %distrub
 x0 = [ 0      0    15*pi/180       0*pi/180          0*pi/180        480*pi/180  ]';% æ¨¡æ“¬?‚¾???15åº?

%% [ t1, x1]= ode45('function_SDRE_0630', tspan, x0)
t0= 0;
t_end= 20;
tspan=[t0 t_end];
%t_MaxStep= 1e-6;
%options= odeset('RelTol', 1e-6, 'AbsTol', 1e-6, 'Refine', 5, 'Stat', 'on', 'MaxStep', t_MaxStep);

%[ t1, x1]= ode45('function_SDRE_0630', tspan, x0)

[t1, x1]= ode45('function_SDRE', tspan, x0);

%% obtain the control input, u, Gamma, and computation time

[u Gain_lqr_data]= function_control_SDRE(t1, x1);
save data.mat
%[Gain_lqr_data]= function_gain_SDRE(t1, x1);
%delete variables_SDRE_disturFig4.mat
%save variables_SDRE_disturFig4
for j= 1: 6
    beep on
end % end for of beep

%% plot
% figure(1)
% subplot(321)
% plot(t1,x1(:,1))
% title('$x$','Interpreter','Latex')
% 
% subplot(323)
% plot(t1,x1(:,2))
% title('$\dot{x }$','Interpreter','Latex')
% 
% subplot(322)
% plot(t1,x1(:,3)*180/pi)
% title('$\theta$','Interpreter','Latex')
% 
% subplot(324)
% plot(t1,x1(:,4)*180/pi)
% title('$\dot{\theta }$','Interpreter','Latex')
% 
% subplot(325)
% plot(t1,x1(:,5)*180/pi)
% title('$\phi$','Interpreter','Latex')
% 
% subplot(326)
% plot(t1,x1(:,6)*180/pi)
% title('$\dot{\phi }$','Interpreter','Latex');hold on
% saveas(gcf,'X')
% 
% figure(2)
% plot(t1,u)
% legend('T_L','T_R')
% title('$u_{SDRE}$','Interpreter','Latex')
% saveas(gcf,'u')
%% 
figure(1)
subplot(511)
plot(t1,x1(:,1))
yline(0,'-.k');
title('$x$','Interpreter','Latex')

subplot(512)
plot(t1,x1(:,2))
yline(0,'-.k');
title('$\dot{x }$','Interpreter','Latex')

subplot(513)
plot(t1,x1(:,3)*180/pi)
yline(0,'-.k');
title('$\theta$','Interpreter','Latex')

subplot(514)
plot(t1,x1(:,4)*180/pi)
yline(0,'-.k');
title('$\dot{\theta }$','Interpreter','Latex')

subplot(515)
plot(t1,u)
% legend('T_L','T_R')
yline(0,'-.k');
title('$u_{SDRE}$','Interpreter','Latex')
saveas(gcf,'u')
