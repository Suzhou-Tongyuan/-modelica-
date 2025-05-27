within Modelica.Mechanics.Translational.Interfaces;
partial model PartialElementaryRotationalToTranslational 
  "用于将旋转运动转换为平移运动的部分模型"
  extends 
    Modelica.Mechanics.Rotational.Interfaces.PartialElementaryRotationalToTranslational;
  annotation (Documentation(info="<html>
<p>这是一个具有以下特点的一维旋转组件：</p>
<ul>
<li>一个旋转一维平动接口，</li>
<li>一个旋转支撑/外壳，</li>
<li>一个平移一维平动接口，</li>
<li>一个平移支撑/外壳。</li>
</ul>
<p>这个模型用于构建驱动传动系统的基本组件，将旋转运动转换为平移运动，并且具备在文本层中描述的相关方程式。</p>
<p>如果 <em>useSupportR=true</em>，则旋转支撑连接器被条件启用，并且需要进行连接。</p>
<p>如果 <em>useSupportR=false</em>，则旋转支撑连接器被条件禁用，旋转部分将内部固定在地面上。</p>
<p>如果 <em>useSupportT=true</em>，则平移支撑连接器被条件启用，并且需要进行连接。</p>
<p>如果 <em>useSupportT=false</em>，则平移支撑连接器被条件禁用，平移部分将内部固定在地面上。</p>
</html>"));
end PartialElementaryRotationalToTranslational;