function ex_3()
%         Implement a cellular automaton (CA) to simulate a diffusion-
%         limited aggregation (DLA) process.
%
%    Author:
%       Thomas Schaffter, PhD student
%       Thomas.Schaffter@epfl.ch
%       http://lis.epfl.ch/161219
%       Laboratory of Intelligent Systems (LIS)
%       Ecole Polytechnique Federale de Lausanne (EPFL)
%       CH-Suisse
%
%    Last modification: 3 nov 2009


%% ------------------------------------------------------------------------
% SETTINGS

% Size of the automaton space (must be divisible by 2)
nx = 40;
ny = 40;

% Initial density of the particles present in the CA space
particlesDensity = 0.01;

% Matrices representing the different component of the CA:
z = zeros(nx,ny);
brownianParticles = z; % particles at time t
newBrownianParticles = z; % particles at time t+1
brownianTree = z; % Brownian tree or "sticky" cluster

% Number of time steps
T = 0;

% Delay between two time steps [s]
delay = 0.1;

% Enable Brownian tree
enableBrownianTree = 0;

% Plot the growth profile of the Brownian tree
plotGrowth = 0;


%% ------------------------------------------------------------------------
% INITIALIZATION

% Fill a fraction of the CA space with particles
brownianParticles = rand(nx,ny) < particlesDensity;


% Seed of the Brownian tree (one cell at the center of the CA space)
brownianTree(nx/2,ny/2) = enableBrownianTree;


% Vector containing the size of the Brownian tree (number of cells) at the
% different time steps
treeSize = [];


% Display the initial state of the CA
h = figure('visible','on');
imh = image(cat(3,brownianTree, brownianTree, brownianParticles));
set(h, 'Name','Ex 3: Diffusion-Limited Aggregation (DLA)','NumberTitle','off')
axis off
axis image


%% ------------------------------------------------------------------------
% RUN

t = 1;
numNeighbours = z; % number of "tree cells" around a moving particle

while (t<T)
    
    % Save the current size of the tree
    if plotGrowth == 1
        treeSize = [treeSize,sum(sum(brownianTree))];
    end


    % ------------------------------
    % --- Pseudo Brownian motion ---
    % ------------------------------
    
    % 1 paricle = 1 matrix element = 1 cell
    % 1 block = 2x2 cells
    
    
    % What is the purpose of this parameter ?
    s = 0;
    %s = mod(t,2);
    
    
    % x (vertical axis) and y (horizontal axis) coordinates of the
    % upper-left cell of each block
    xind = 1+s:2:nx-2+s;
    yind = 1+s:2:ny-2+s;
    
    
    % Matrices cw (clockwise) and ccw (counterclockwise) contain
    % complementary binary values (0 or 1).
    cw = rand(nx,ny)<.5; 
    ccw = 1-cw;
    
    
    % In every block, randomize the movement of the particles by rotating
    % them either cw or ccw.
    % Update upper-left cells
    newBrownianParticles(xind,yind) = ...
        cw(xind,yind).*brownianParticles(xind+1,yind) + ... % cw
        ccw(xind,yind).*brownianParticles(xind,yind+1) ;    % ccw
    
    % Update lower-left cells
    newBrownianParticles(xind+1,yind) = ...
        cw(xind,yind).*brownianParticles(xind+1,yind+1) + ...
        ccw(xind,yind).*brownianParticles(xind,yind) ;

    % Wpdate upper-right cells
    newBrownianParticles(xind,yind+1) = ...    
        cw(xind,yind).*brownianParticles(xind,yind) + ...
        ccw(xind,yind).*brownianParticles(xind+1,yind+1) ;
        
    % Update lower-right cells
     newBrownianParticles(xind+1,yind+1) = ...    
        cw(xind,yind).*brownianParticles(xind,yind+1) + ...
        ccw(xind,yind).*brownianParticles(xind+1,yind) ;
    
    
    % Save the new positions of the particles
    brownianParticles = newBrownianParticles;
    
    
    % -----------
    % --- End ---
    % -----------
    
    
    % For each particle, count how many sticky cells (belonging to the
    % Brownian tree) there are in its neighborhood. The result is saved in
    % the following (nx-2)x(ny-2) matrix.
    numNeighbours(2:nx-1,2:ny-1) = brownianTree(2:nx-1,1:ny-2) + ...
                         brownianTree(2:nx-1,3:ny) + ...
                         brownianTree(1:nx-2, 2:ny-1) +...
                         brownianTree(3:nx,2:ny-1) + ...
                         brownianTree(1:nx-2,1:ny-2) + ...
                         brownianTree(1:nx-2,3:ny) + ...
                         brownianTree(3:nx,1:ny-2) + ...
                         brownianTree(3:nx,3:ny);
                     
    
    % Update the Brownian tree
    brownianTree = ((numNeighbours>0) & (brownianParticles==1)) | brownianTree ;
    % Remove the particles from "brownianParticles" that are now part of the tree.
    % -> conservation of the particles
    brownianParticles(brownianTree==1) = 0;
    
    
    % Update the display
    % Tip: you can comment the 6 next instructions to speed up the plot of
    % the growth profile of the tree.
    if ishandle(imh)
        set(imh, 'CData', cat(3,brownianTree,brownianTree,brownianParticles));
        drawnow
    else
        return
    end

    
    pause(delay);
    t=t+1;
end


%% ------------------------------------------------------------------------

% Plot the growth profile of the tree
if plotGrowth == 1
    plot(treeSize(1:T-1));
    xlabel('Time [iteration]');
    ylabel('Tree size [cells]');
end

