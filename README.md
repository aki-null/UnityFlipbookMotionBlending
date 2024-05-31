Unity Flipbook Motion Blending
===

This repository contains a flipbook motion blending shader for Unity.

I am using this to test my upcoming tool that generates motion vectors from flipbook frames rendered in tools that lack motion vector export features.

This is an early prototype and can be used as a reference implementation. However, the shader lacks various features, such as support for Shuriken custom vertex streams.

Motion vector textures can be generated using Houdini or my upcoming tool.

## Calculating Motion Strength

The value for motion strength depends on how you generated the motion vector texture. Some tools (including my WIP tool) will tell you what this value is when you export, so in such cases, you can just copy and paste the value into the material.

If your tool's vector output is frame rate (FPS) driven, the parameter can be calculated as the reciprocal of the FPS.

$$\text{Motion Strength} = \frac{1}{\text{Frame Rate}}$$

For example, if your render configuration is set to 24fps, the motion strength will be 0.041667.

Labs Flipbook Textures render node uses this approach; however, the Max Speed Allowed value may affect the strength, so you might need to adjust the value if you are working with fast-moving animation.

For tools where you can configure the displacement strength, the parameter can be calculated by dividing it by the frame resolution.

$$\text{Motion Strength} = \frac{\text{Displacement Strength}}{\text{Frame Resolution}}$$

For example, if you set the maximum displacement to 10 and your frame resolution is 128x128, the motion strength will be 0.078125.
