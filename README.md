# Unity Shaders

Project about reseach on shaders and particle systems and how to use them in Unity. This project consists of several scenes in which I have been learning about using shaders, particle systems and how to program custom graphics. Scenes in this projects are made by following various tutorials from internet and by changing them to get better understanding how they actually work.   
  
This project consist of 6 parts:  
## 1. UI and camera shaders  
#### UI shaders.unity  

This scene has 3 different simple shaders to manipulate UI and camera view. Shaders are changing borders of UI image and making "spooky" effect on UI text. Third shader is shifting camera view with sine function.  
Also, this was my first contact with creating shaders.  

![alt text](https://github.com/igradeca/Unity-Shaders/blob/master/shaders1.jpg)
  
## 2. Ripple effect
#### Ripple scene.unity  

By clicking with left mouse in the scene shader will start to create ripples over attached material. With changing different parameters we can adjust size and look of the creating ripples. 

![alt text](https://github.com/igradeca/Unity-Shaders/blob/master/shaders2.jpg)
  
## 3. Hologram effect
#### Hologram scene.unity  

Hologram looking effect which can be nice for some SF game. Combining vertices with different operations we can easly get interesting results.

![alt text](https://github.com/igradeca/Unity-Shaders/blob/master/hologram%20shader.jpg)
  
## 4. Night vision
#### scene 4 night vision.unity  

Image effect for camera to get the look of night vision googles. Whole idea is to calculate image depth and then dim out objects that are too far. To get more realistic results, green color is added together with mask. Also Unity's Standard Asset was added to get low light noise effect.

![alt text](https://github.com/igradeca/Unity-Shaders/blob/master/shader%20night%20vision.jpg)
  
## 5. Snow simulation
#### Snow scene.unity  

This scene shows tessellation shader used as snow material. Main goal of this scene is to make changes on material when some object touches it and to make depths in it. These depth are calculated in real time and can be seen depending on how deep some object has went through snow. Also snow falling simulator is added to fill depths over time.

![alt text](https://github.com/igradeca/Unity-Shaders/blob/master/snow%20shader.jpg)
  
## 6. Dissolve effect (particle system & shader)
#### Dissolve scene.unity  

Combining particle systems with shader we get objects dissolving effect when they are at enought distance from source.

![alt text](https://github.com/igradeca/Unity-Shaders/blob/master/dissolve.jpg)
 
## 7. Fire effect (particle system)
#### Fire1 scene.unity & Fire2 scene.unity

Simulations of fire effect made with several particle system objects.

![alt text](https://github.com/igradeca/Unity-Shaders/blob/master/fire%20particles.jpg)
