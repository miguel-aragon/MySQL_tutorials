#CREATE DATABASE 100Mpc_Halos;

USE 100Mpc_Halos;

# ---------------------------
#   Run properties
# ---------------------------
DROP TABLE IF EXISTS Simulation_Parameters;
CREATE TABLE Simulation_Parameters (
  Aexp     FLOAT(24,8), # --- Expansion factor 
  Omega_M  FLOAT(24,8), # --- Omega Matter
  Omega_L  FLOAT(24,8), # --- Omega Lambda
  Omega_B  FLOAT(24,8), # --- Omega barion
  Hubble   FLOAT(24,8),
  BoxSize  FLOAT(24,8),
  Npart    INT,         # --- Total number of particles
  PartMass FLOAT(24,8), # --- Mass per particle * 10^10 M_o
  GridSize INT          # --- Grid size used for density field, spine, etc.
  SclDen1    FLOAT(24,8), # --- Scales used for Tophat and Gaussian densities
  SclDen2    FLOAT(24,8),
  SclDen3    FLOAT(24,8),
  SclDen4    FLOAT(24,8),
  SclDen5    FLOAT(24,8),
  SclHes1    FLOAT(24,8), # --- Scales used for Hessian analysis
  SclHes2    FLOAT(24,8),
  SclHes3    FLOAT(24,8)
);

# ---------------------------
#   Halo basic properties
# ---------------------------
DROP TABLE IF EXISTS Halo_Prop;
CREATE TABLE Halo_Prop (
  #--------------------
  #--- HALO CONTEXT
  #--------------------  
  IdComp   BIGINT NOT NULL PRIMARY KEY, #--- Composite index [HaloType, SnapNum, Id]
  IdLocal  INT    NOT NULL,             #--- Halo Id in its own context (SnapNum and HaloType)
  SnapNum  INT,           #--- Snapshot number
  HaloType TINYINT,       #--- FoF of SubFind halo
  aExp     FLOAT(24,8),   #--- Expansion factor
  #--------------------
  #--- BASIC PROPERTIES
  #--------------------  
  x         FLOAT(24,8) NOT NULL, #--- Position components (Kpc)...
  y         FLOAT(24,8) NOT NULL, 
  z         FLOAT(24,8) NOT NULL, 
  vx        FLOAT(24,8) NOT NULL, #--- Velocity components (km/s)...
  vy        FLOAT(24,8) NOT NULL, 
  vz        FLOAT(24,8) NOT NULL,
  mass      FLOAT(24,8) NOT NULL, #--- Mass, number of particles
  #--- DIFFERENT RADIUS MEASURES
  VirRadius FLOAT(24,8),  #--- Virial radius (Kpc)
  MaxRadius FLOAT(24,8),  #--- Maximum radius (Kpc)
  HarRadius FLOAT(24,8),  #--- Harmonic radius (Kpc)
  #--- DYNAMICAL GENERAL PROPERTIES
  VelDisp   FLOAT(24,8),  #--- Velocity dispersion
  CircVel   FLOAT(24,8),  #--- Circular velocity
  #--- NFW HALO MODEL
  NFW_rho_0 FLOAT(24,8),  #--- NFW Central density
  NFW_R_s   FLOAT(24,8),  #--- NFW Scale radius
  NFW_c_s   FLOAT(24,8),  #--- NFW Concentration parameter
  #--- ANGULAR MOMENTUM AND SHAPE
  LMod FLOAT(24,8), # --- Angular momentum magnitude
  Lx   FLOAT(24,8), # --- Angular momentum components...
  Ly   FLOAT(24,8), 
  Lz   FLOAT(24,8), 
  I1   FLOAT(24,8), # --- Largest  Inertia tensor component
  I2   FLOAT(24,8), # --- Medium   Inertia tensor component
  I3   FLOAT(24,8), # --- Smallest Inertia tensor component
  I1x  FLOAT(24,8), # --- Inertia tensor direction (smallest)...
  I1y  FLOAT(24,8), 
  I1z  FLOAT(24,8), 
  I2x  FLOAT(24,8), # --- Inertia tensor direction (medium)...
  I2y  FLOAT(24,8), 
  I2z  FLOAT(24,8), 
  I3x  FLOAT(24,8), # --- Inertia tensor direction (large)...
  I3y  FLOAT(24,8),
  I3z  FLOAT(24,8),
  #--------------------
  #--- HALF-RADIUS PROPERTIES
  #--------------------
  MaxRadius_half FLOAT(24,8),  #--- Maximum radius (Kpc)
  HarRadius_half FLOAT(24,8),  #--- Harmonic radius (Kpc)
  VelDisp_half   FLOAT(24,8),  #--- Velocity dispersion
  CircVel_half   FLOAT(24,8),  #--- Circular velocity
  LMod_half   FLOAT(24,8), # --- Angular momentum magnitude
  Lx_half     FLOAT(24,8), # --- Angular momentum components
  Ly_half     FLOAT(24,8), 
  Lz_half     FLOAT(24,8), 
  I1_half     FLOAT(24,8), # --- Largest  Inertia tensor component
  I2_half     FLOAT(24,8), # --- Medium   Inertia tensor component
  I3_half     FLOAT(24,8), # --- Smallest Inertia tensor component
  I1x_half    FLOAT(24,8), # --- Inertia tensor direction 
  I1y_half    FLOAT(24,8), 
  I1z_half    FLOAT(24,8), 
  I2x_half    FLOAT(24,8), 
  I2y_half    FLOAT(24,8), 
  I2z_half    FLOAT(24,8), 
  I3x_half    FLOAT(24,8), 
  I3y_half    FLOAT(24,8), 
  I3z_half    FLOAT(24,8),
  #--------------------
  #--- MERGING TREE RELATIONS
  #--------------------
  ParentHaloId INT, #--- If of parent halo (-1 if has no parent)
  N_child      INT, #--- Number of child haloes
  #--------------------
  #--- DENSITY ESTIMATES
  #--------------------
  Top1   FLOAT(24,8), # --- TopHat density
  Top2   FLOAT(24,8),
  Top3   FLOAT(24,8),
  Top4   FLOAT(24,8),
  Top5   FLOAT(24,8),
  Gau1   FLOAT(24,8), # --- Gaussian density
  Gau2   FLOAT(24,8),
  Gau3   FLOAT(24,8),
  Gau4   FLOAT(24,8),
  Gau5   FLOAT(24,8),
  DTFE   FLOAT(24,8)  # --- DTFE adaptive density
  #--------------------
  #--- HESSIAN OF DENSITY FIELD
  #--------------------
  #--- Scale 1
  HessE1_S1   FLOAT(24,8), # --- Smallest Hessian eigenvalue
  HessE2_S1   FLOAT(24,8), # --- Medium   Hessian eigenvalue 
  HessE3_S1   FLOAT(24,8), # --- Largest  Hessian eigenvalue 
  HessE1x_S1  FLOAT(24,8), # --- Hessian Eigenvectors...
  HessE1y_S1  FLOAT(24,8),
  HessE1z_S1  FLOAT(24,8),
  HessE2x_S1  FLOAT(24,8),
  HessE2y_S1  FLOAT(24,8),
  HessE2z_S1  FLOAT(24,8),
  HessE3x_S1  FLOAT(24,8),
  HessE3y_S1  FLOAT(24,8),
  HessE3z_S1  FLOAT(24,8),   
  #--- Scale 2
  HessE1_S2   FLOAT(24,8), # --- Smallest Hessian eigenvalue
  HessE2_S2   FLOAT(24,8), # --- Medium   Hessian eigenvalue 
  HessE3_S2   FLOAT(24,8), # --- Largest  Hessian eigenvalue 
  HessE1x_S2  FLOAT(24,8), # --- Hessian Eigenvectors...
  HessE1y_S2  FLOAT(24,8),
  HessE1z_S2  FLOAT(24,8),
  HessE2x_S2  FLOAT(24,8),
  HessE2y_S2  FLOAT(24,8),
  HessE2z_S2  FLOAT(24,8),
  HessE3x_S2  FLOAT(24,8),
  HessE3y_S2  FLOAT(24,8),
  HessE3z_S2  FLOAT(24,8),
  #--- Scale 3
  HessE1_S3   FLOAT(24,8), # --- Smallest Hessian eigenvalue
  HessE2_S3   FLOAT(24,8), # --- Medium   Hessian eigenvalue 
  HessE3_S3   FLOAT(24,8), # --- Largest  Hessian eigenvalue 
  HessE1x_S3  FLOAT(24,8), # --- Hessian Eigenvectors...
  HessE1y_S3  FLOAT(24,8),
  HessE1z_S3  FLOAT(24,8),
  HessE2x_S3  FLOAT(24,8),
  HessE2y_S3  FLOAT(24,8),
  HessE2z_S3  FLOAT(24,8),
  HessE3x_S3  FLOAT(24,8),
  HessE3y_S3  FLOAT(24,8),
  HessE3z_S3  FLOAT(24,8),
  #--------------------
  #--- TIDAL FIELD (NO SCALE)
  #--------------------
  Tid_1   FLOAT(24,8), # --- Smallest eigenvalue 
  Tid_2   FLOAT(24,8), # --- Medium   eigenvalue 
  Tid_3   FLOAT(24,8), # --- Largest  eigenvalue 
  Tid_1x  FLOAT(24,8), # --- Eigenvectors...
  Tid_1y  FLOAT(24,8),
  Tid_1z  FLOAT(24,8),
  Tid_2x  FLOAT(24,8),
  Tid_2y  FLOAT(24,8),
  Tid_2z  FLOAT(24,8),
  Tid_3x  FLOAT(24,8),
  Tid_3y  FLOAT(24,8),
  Tid_3z  FLOAT(24,8),
  #--------------------
  #--- SPINEWEB
  #--------------------
  PVoid1    INT,         #--- Parent void, level 1
  PVoid2    INT,         #--- Parent void, level 1-2
  PVoid3    INT          #--- Parent void, level 1-2-3
  #--- Basic morphology (see notes)
  SpineDim1 TINYINT,     #--- Basic spine morphology,level 1
  SpineDim2 TINYINT,     #--- Basic spine morphology,level 2
  SpineDim3 TINYINT,     #--- Basic spine morphology,level 3
  #--- Distance to closest WALL
  WallDist1 FLOAT(24,8), #--- Distance to closest wall, level 1
  WallId1   INT,         #--- Id of closest wall,       level 1
  WallDist2 FLOAT(24,8), #--- Distance to closest wall, level 1-2
  WallId2   INT,         #--- Id of closest wall,       level 1-2
  WallDist3 FLOAT(24,8), #--- Distance to closest wall, level 1-2-3
  WallId3   INT,         #--- Id of closest wall,       level 1-2-3
  #--- Distance to closest FILAMENT
  FilaDist1 FLOAT(24,8), #--- Distance to closest filament, level 1
  FilaId1   INT,         #--- Id of closest filament,       level 1
  FilaDist2 FLOAT(24,8), #--- Distance to closest filament, level 1-2
  FilaId2   INT,         #--- Id of closest filament,       level 1-2
  FilaDist3 FLOAT(24,8), #--- Distance to closest filament, level 1-2-3
  FilaId3   INT          #--- Id of closest filament,       level 1-2-3
);

