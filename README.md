# FLV (Forest Landscape Visualization)
[Case applications](https://bit.ly/3eN5Qlk)
## 1 Platform operation preparation
This platform integrates several software and programming languages. The software includes **Photoshop**, **Speedtree**, **Houdini Engine** and **Unreal Engine**, and the programming languages include **Python** and **R**. The workflow consists of processing data and 3D visualization. First, we installed the software and configured the compilation environment for these programming languages. Then we show the use of the platform with the output of the LANDIS PRO forest landscape model as an example.
## 2 Processing of landscape model output results
### 2.1 LANDIS PRO output results sorting classification
All the outputs of the LANDIS PRO forest landscape model are in the same folder, including raster files that characterize different properties of trees of different years, ages, and species. We placed these files in the `Output` folder with the following file structure. <br/>
<img src="https://github.com/flvyhy/jpg/blob/main/1.png" width=600><br/>
Running the *`treenum2year.py`* file will group the tree count files from the originally mixed files into the same folder `TreeNum` by year.

### 2.1 Age grouping of LANDIS PRO output results<br/>
<img src="https://github.com/flvyhy/jpg/blob/main/2.png" width=600><br/>
*`specname.txt`* : Column 1 is the name of the tree species; the numbers in columns 2-5 are the columns where the intermittent ages of the age groups are located; columns 6-23 are the ages of the output files for each tree species.<br/>
<img src="https://github.com/flvyhy/jpg/blob/main/3.png" width=600><br/>
Run the *`ageclass.R`* file. The raster data within the age groups can be summed according to the age group settings in the *`specname.txt`* file to obtain a raster plot of the number of trees in different age groups.<br/>
<img src="https://github.com/flvyhy/jpg/blob/main/4.png" width=400><br/>
The forest landscape to be visualized in the forest landscape model simulation may be divided into several parts for separate simulation, which requires organizing the two parts separately. The organized folders are placed hierarchically in the order shown in the figure below. <br/>
<img src="https://github.com/flvyhy/jpg/blob/main/5.png" width=400><br/>
Run the *`Distribution&Abundance.R`* code file, stitch the two parts together and generate the density distribution and the corresponding quantity table.

# 2 Three-dimensional visualization of forest landscape
## 2.1 Data transmission
We use Houdini Engine for bridging the gap between the output data and the game engine. In Houdini Engine, terrain data, forest data, river data, and road data are integrated together to make a HAD package that is used to build the entire scene in Unreal Engine.<br/>
<img src="https://github.com/flvyhy/jpg/blob/main/6.png" width=500><br/><img src="https://github.com/flvyhy/jpg/blob/main/7.png" width=600>

## 2.2 Scene Generation
Drag the HAD package <img src="https://github.com/flvyhy/jpg/blob/main/8.png" width=40> into Unreal Engine and the entire scene will be generated automatically.<br/>
<img src="https://github.com/flvyhy/jpg/blob/main/9.png" width=1000><br/>
Optimization of scenes in Unreal Engine and the way to navigate can be found in the [learning rescoures](https://www.unrealengine.com/learn) on the official website.
