>## **Gastag**
>
>**Gastag is a system that uses passive metamaterial tags to sense gases by using RFID technology.**
>
>**PSO (Particle Swarm Optimization) is an auxiliary algorithm in our antenna design process, which is used to select the designated antenna structure parameters. It effectively reduces the time and computational power consumption, when facing multiple structure parameters adjustment.**
>
>****
>
>## **Prepare**
>
>**Before running, check the following conditions:**
>
>1. **The parameters of material**
>
>   **a. For example, Gastag uses PET (Polyethylene Terephthalate) as the substrate, its relative permittivity is 3, and its dielectric loss tangent is 0.0012.**
>
>   **b. For example, Gastag uses BOPP (Biaxially Oriented Polypropylene) as the encapsulation, its relative permittivity is 2.25, and its dielectric loss tangent is 0.0005.**
>
>2. **Make sure the result, script, and array folders, which are under the current path, are empty or do not exist.**
>
>3. **Make sure there is a High Frequency Structure Simulator (HFSS) model in the current folder that can be simulated correctly.**
>
>**The simulation model is designed for dedicated situation. For example, in Gastag, there are three floors, the bottom layer is a PET as the substrate, the middle is a copper film that has been engraved using laser printing technology and sensing film, and the top layer is BOPP as the encapsulation. The whole model is mainly composed of eleven parameters. The meanings of the parameters are listed below:**
>
>- **R1：The radius of the loop antenna**
>- **R2：The radius of the load**
>- **L1：The length of the coupling section**
>- **L2：The length of the dipole antenna bend**
>- **L3：The width of the bend of the dipole antenna**
>- **L4：The length of the part that connects the load**
>- **P：The width of the loop antenna**
>- **Q：The width of the dipole antenna**
>- **th：The length of the sensitive material**
>- **ph：The distance from the sensitive material to the chip**
>- **v：The width of the copper wire**
>
>****
>
>## **Software**
>
>**Gastag runs on the following softwares :**
>
>1. **Matlab 2019**
>
>2. **Ansys Electronics Suite 2021 R2**
>
>**We did not check the compatibility between the different versions, changing the version may cause errors.**
>
>**** 
>
>## **Guide**
>
>1. **Meaning of the file :**
>
>- **result folder: Store the real and imaginary parts of impedance data exported from the optimized antenna structure**
>- **array: Store the HFSS model after population initialization**
>- **script: Store the script file used to run HFSS**
>- **parameter: Store the structure parameters that fit the conditions**
>
>2. **Function introduction :**
>
>**pso.m : Main program. Calculates new iteration parameters based on the returned fitness**
>
>- **calfit.m : Calculate the fitness function**
>- **copyArray.m : Copy the model and initialize the population**
>- **getData.m : Get the structure parameters that meet the condition**
>- **hfssExecute.m : Invoke HFSS to execute**
>- **makescript.m : Generate the HFSS execution scripts0**
>- **islegal.m : Determine whether the parameters are under the restriction**
>
>3. **tag.sab : Gastag model**
>
>**** 
>
>## **Use Flow**
>
>**Before you start this process, make sure all the preparations are complete:**
>
>- **Step1 : Modify the path of the Ansys Electronics Suite application software**
>- **Step2 : Modify the model name in copyArray.m**
>- **Step3 : Run pso.m**
>
>****