CREATE DATABASE DR7_GALS

USE DR7_GALS;


# ---------------------------
#   Halo basic properties
# ---------------------------
DROP TABLE IF EXISTS PhotoSpec;
CREATE TABLE PhotoSpec (
  ObjID      BIGINT      NOT NULL PRIMARY KEY, 
  ra         FLOAT(24,8) NOT NULL, 
  de         FLOAT(24,8) NOT NULL, 
  z          FLOAT(24,8) NOT NULL, 
  zErr       FLOAT(24,8), 
  zConf      FLOAT(24,8), 
  cx         FLOAT(24,8) NOT NULL,
  cy         FLOAT(24,8) NOT NULL, 
  cz         FLOAT(24,8) NOT NULL,
  zStatus    FLOAT(24,8),
  zWarning   FLOAT(24,8), 
  velDisp    FLOAT(24,8), 
  velDispErr FLOAT(24,8), 
  specClass  FLOAT(24,8), 
  eClass     FLOAT(24,8), 
  IsoPhi_u   FLOAT(24,8),  #--- Isophotal position angle
  IsoPhi_g   FLOAT(24,8), 
  IsoPhi_r   FLOAT(24,8), 
  IsoPhi_i   FLOAT(24,8), 
  IsoPhi_z   FLOAT(24,8), 
  IsoA_u     FLOAT(24,8),  #--- Isophotal major semiaxis
  IsoA_g     FLOAT(24,8), 
  IsoA_r     FLOAT(24,8), 
  IsoA_i     FLOAT(24,8), 
  IsoA_z     FLOAT(24,8),
  IsoB_u     FLOAT(24,8),  #--- Isophotal minor semiaxis
  IsoB_g     FLOAT(24,8),
  IsoB_r     FLOAT(24,8),
  IsoB_i     FLOAT(24,8), 
  IsoB_z     FLOAT(24,8),
  PetroR50_u FLOAT(24,8),  #--- Petrosian radius enclosing 50 % of light
  PetroR50_g FLOAT(24,8),
  PetroR50_r FLOAT(24,8),
  PetroR50_i FLOAT(24,8),
  PetroR50_z FLOAT(24,8),
  PetroR90_u FLOAT(24,8),  #--- Petrosian radius enclosing 90 % light
  PetroR90_g FLOAT(24,8),
  PetroR90_r FLOAT(24,8),
  PetroR90_i FLOAT(24,8),
  PetroR90_z FLOAT(24,8),
  PetroRad_u FLOAT(24,8),  #--- Petrosian radius 
  PetroRad_g FLOAT(24,8),
  PetroRad_r FLOAT(24,8),
  PetroRad_i FLOAT(24,8),
  PetroRad_z FLOAT(24,8) 
);

# ==============================================
#                    Groups
# ==============================================
# ---------------------------
#   Friends of friends groups
# ---------------------------
DROP TABLE IF EXISTS FoFGroups;
CREATE TABLE FoFGroups (
  ObjId   BIGINT NOT NULL PRIMARY KEY,
  weight  FLOAT(24,8), # --- TopHat window of 1 Mpc/h
  GroupId INT,
  GroupMulti INT,
};

# ==============================================
#                    DENSITY
# ==============================================
# ---------------------------
#   Several density estimates
# ---------------------------
DROP TABLE IF EXISTS Density;
CREATE TABLE Density (
  ObjId   BIGINT NOT NULL PRIMARY KEY,
  Top1   FLOAT(24,8), # --- TopHat window of 1 Mpc/h
  Top3   FLOAT(24,8), # --- TopHat window of 3 Mpc/h
  Top5   FLOAT(24,8), # --- TopHat window of 5 Mpc/h
  Top8   FLOAT(24,8), # --- TopHat window of 8 Mpc/h
  Gau1   FLOAT(24,8), # --- Gaussian window of 1 Mpc/h
  Gau3   FLOAT(24,8), # --- Gaussian window of 3 Mpc/h
  Gau5   FLOAT(24,8), # --- Gaussian window of 5 Mpc/h
  Gau8   FLOAT(24,8), # --- Gaussian window of 8 Mpc/h
  DTFE   FLOAT(24,8)  # --- DTFE adaptive density
);

# ==============================================
#                    MMF
# ==============================================
# ---------------------------
#   MMF Properties. Computed from
#   the Hessian of the density field
#   at a given scale
# ---------------------------
DROP TABLE IF EXISTS Den_Hess;
CREATE TABLE Den_Hess (
  ObjId   BIGINT NOT NULL PRIMARY KEY,
  #--- Scale 0
  E1_S0   FLOAT(24,8), # --- Smallest Hessian eigenvalue
  E2_S0   FLOAT(24,8), # --- Medium   Hessian eigenvalue 
  E3_S0   FLOAT(24,8), # --- Largest  Hessian eigenvalue 
  E1x_S0  FLOAT(24,8), # --- Hessian Eigenvectors
  E1y_S0  FLOAT(24,8),
  E1z_S0  FLOAT(24,8),
  E2x_S0  FLOAT(24,8),
  E2y_S0  FLOAT(24,8),
  E2z_S0  FLOAT(24,8),
  E3x_S0  FLOAT(24,8),
  E3y_S0  FLOAT(24,8),
  E3z_S0  FLOAT(24,8),   
  #--- Scale 1
  E1_S1   FLOAT(24,8), # --- Smallest Hessian eigenvalue
  E2_S1   FLOAT(24,8), # --- Medium   Hessian eigenvalue 
  E3_S1   FLOAT(24,8), # --- Largest  Hessian eigenvalue 
  E1x_S1  FLOAT(24,8), # --- Hessian Eigenvectors
  E1y_S1  FLOAT(24,8),
  E1z_S1  FLOAT(24,8),
  E2x_S1  FLOAT(24,8),
  E2y_S1  FLOAT(24,8),
  E2z_S1  FLOAT(24,8),
  E3x_S1  FLOAT(24,8),
  E3y_S1  FLOAT(24,8),
  E3z_S1  FLOAT(24,8),
  #--- Scale 2
  E1_S2   FLOAT(24,8), # --- Smallest Hessian eigenvalue
  E2_S2   FLOAT(24,8), # --- Medium   Hessian eigenvalue 
  E3_S2   FLOAT(24,8), # --- Largest  Hessian eigenvalue 
  E1x_S2  FLOAT(24,8), # --- Hessian Eigenvectors
  E1y_S2  FLOAT(24,8),
  E1z_S2  FLOAT(24,8),
  E2x_S2  FLOAT(24,8),
  E2y_S2  FLOAT(24,8),
  E2z_S2  FLOAT(24,8),
  E3x_S2  FLOAT(24,8),
  E3y_S2  FLOAT(24,8),
  E3z_S2  FLOAT(24,8)  
);

# ==============================================
#                    SPINE 
# ==============================================
# ---------------------------
#   Hierarchical spine properties
# ---------------------------
DROP TABLE IF EXISTS SpineWeb;
CREATE TABLE SpineWeb (
  ObjId          BIGINT NOT NULL PRIMARY KEY, 
  Morph_dim_L012 TINYINT, # --- Hierarchical spine dimension: 0-node,1-filament,2-wall,3-void
  #--- Level 0
  Morph_dim_L0   TINYINT, # --- Morphology dimension: 0-node,1-filament,2-wall,3-void
  Morph_Id_L0    INT,     # --- Unique ID for this morphology object
  Dist_Spine_L0  FLOAT(24,8),   # --- Euclidean distance from closest spine element
  Dist_Wall_L0   FLOAT(24,8),   # --- Euclidean distance from closest wall
  Dist_Fila_L0   FLOAT(24,8),    # --- Euclidean distance from closest filament
  #--- Level 1
  Morph_dim_L1   TINYINT, # --- Morphology dimension: 0-node,1-filament,2-wall,3-void
  Morph_Id_L1    INT,     # --- Unique ID for this morphology object
  Dist_Spine_L1  FLOAT(24,8),   # --- Euclidean distance from closest spine element
  Dist_Wall_L1   FLOAT(24,8),   # --- Euclidean distance from closest wall
  Dist_Fila_L1   FLOAT(24,8),    # --- Euclidean distance from closest filament
  #--- Level 2
  Morph_dim_L2   TINYINT, # --- Morphology dimension: 0-node,1-filament,2-wall,3-void
  Morph_Id_L2    INT,     # --- Unique ID for this morphology object
  Dist_Spine_L2  FLOAT(24,8),   # --- Euclidean distance from closest spine element
  Dist_Wall_L2   FLOAT(24,8),   # --- Euclidean distance from closest wall
  Dist_Fila_L2   FLOAT(24,8)    # --- Euclidean distance from closest filament
);


# ==============================================
#                    TIDAL
# ==============================================
# ---------------------------
#   Tidal field tensor computed from potential
#   Eigenvalues and eigenvectors
# ---------------------------
DROP TABLE IF EXISTS Tidal;
CREATE TABLE Tidal (
  ObjId BIGINT NOT NULL PRIMARY KEY, 
  T1   FLOAT(24,8), # --- Smallest eigenvalue 
  T2   FLOAT(24,8), # --- Medium   eigenvalue 
  T3   FLOAT(24,8), # --- Largest  eigenvalue 
  T1x  FLOAT(24,8), # --- Eigenvectors
  T1y  FLOAT(24,8),
  T1z  FLOAT(24,8),
  T2x  FLOAT(24,8),
  T2y  FLOAT(24,8),
  T2z  FLOAT(24,8),
  T3x  FLOAT(24,8),
  T3y  FLOAT(24,8),
  T3z  FLOAT(24,8)  
);



