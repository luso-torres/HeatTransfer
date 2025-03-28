# Heat Transfer algorithm

The documents presented here were developed to demonstrate the heat transfer (conduction and convection) on a 2D-structural Finn applying the finite domain analysis CVFEM (Control Volume Finite Element Method).

The proposed algorithm achieved a 97.8% efficiency compared to the analytical result.

This is a symmetric problem solution with the following boundary conditions:
- The object is at a fixed tempearture at one of the ends ($200^\circ C$);
- The environment temperature ($T_\infty$) is $25^\circ C$

Inside the folder "codigos" we can find 8 different codes, as follows:
## 1. Monta_A
Calculate the coefficients $C_{ij}$ generated by the discretization of the Integral-Differential Equation represeting the Heat Transfer (more details in the section 2.4 of the document Trabalho_1_TRANSCAL). The main purpose of this function is to convert the differential equation to its equivalent discrete form below:
```math
$$ \int_{Vc}\nabla{\cdot (K\nabla{T})}dV = [A] [T] $$
```
Where $[A]$ represents a 3-dimensional Matrix and $[T]$ represent 3-dimensional vector containing $x,y$ and $z$ components.

### Usage

```MATLAB
function [A] = Monta_A(k,P,T)

```
Inputs:
- $k$ is the heat transfer coefficient.
- $P$ represents the number of nodes inside the mesh.
- $T$ represents the temperature of each node.

Outputs:
- $A_{ij}$ coefficients of the equivalent 3D heat transfer matrix.
 
## 2. area_contorno
Calculate the areas related to each node in the contour and returns its respective normal vector.

### Usage

```MATLAB
function [Aglobal,Xbci,Ybci] = area_contorno(P,E,T,n_contorno)

```

Inputs:
- $P$ represents the number of nodes inside the mesh.
- $E$ is the heat transfer coefficient.
- $T$ represents the temperature of each node.
- $n_{contorno}$ represents the node in the contour.


Outputs:
- $Aglobal$  is the global coefficient of the equivalent 3D heat transfer matrix (all points).
- $Xbci,Ybci$ are the center node equivalent coordinates.

## 3. cod_principal
It is the main function of this module, responsible to assemble each code descripted in this document. Its outputs are a set of images containing the results of the mesh generation, heat transfer rate and errors.
Some of the results are:
![campolit](https://github.com/user-attachments/assets/78f25d48-f8ef-4445-9d6a-ba12a77d1ccb)
![erroQ (1)](https://github.com/user-attachments/assets/8a2f539a-64fb-40af-a8e6-7ab69bc068ca)



## 4. gradiente 
This functions calculates the temperature gradients as finite differences between each element inside the mesh.

### Usage
```MATLAB
function [k_dT_dxi,k_dT_dyi,ki] = gradiente(ke,Temp,P,E,T)

```

Inputs:
- $ke$ represents the equivalent temperature (average).
- $Temp$ represent the concatenation of the temperatures. 
- $P$ represents the number of nodes inside the mesh.
- $E$ is the heat transfer coefficient.
- $T$ represents the temperature of each node.
- $n_contorno$ represents the node in the contour.


Outputs:
- $KdTdxi,KdTdyi$  are the heat transfer rates values for $x$ and $y$, respectively.
- $ki$ is the $i$-th heat transfer coefficient for each node i.

## 5. malha_grossa
This codes generates the CVFEM coarse mesh.

### Output
![malha_grossa](https://github.com/user-attachments/assets/2fe438cd-364c-4a0e-8b97-78d6dd757993)


## 6. malha_refinada_manual_1 
This codes generates the CVFEM coarse mesh with higher quality.

### Output
![Malha_refinada_1](https://github.com/user-attachments/assets/776e8373-adba-49c2-987e-890270195e31)


## 7. malha_refinada_manual_2 
This codes generates the CVFEM fine mesh.

### Output
![Malha_refinada_2](https://github.com/user-attachments/assets/23fe03b2-0169-4811-9806-eed300a0a381)

