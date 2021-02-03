# Scanner

在脚本中用相机获取当前的深度图，在片段着色器中，获取某个点的深度值，如果在阈值范围内就改变颜色。

![scanner](.\Pics\Scanner.jpg)

这个效果通过屏幕后处理的方式实现。关于屏幕后处理，主要是用到**OnRenderer(RenderTexture src, RenderTexture dst)**函数。Unity把当前渲染得到的图像存储在src中，然后通过函数进行一系列操作后，再把dst图像显示到屏幕上。

在OnRenderer函数中，通常利用**Graphics.Blit(src, dst, mat, int pass)**函数来完成对纹理的处理，mat是我们使用的材质。src纹理会被传递到mat对应的Shader中的_MainTex，参数pass的默认值为-1，表示将会依次调用Shader内的所有pass。