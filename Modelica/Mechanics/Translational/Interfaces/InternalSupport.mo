within Modelica.Mechanics.Translational.Interfaces;
model InternalSupport 
  "适配器模型，用于条件支撑连接器"
  input SI.Force f 
    "外部支撑力（必须通过在使用 InternalSupport 的模型中进行力平衡计算; = flange.f)";
  SI.Position s "外部支撑位置（= flange.s）";
  Flange_a flange 
    "内部支撑一维平动接口（必须连接到带有 useSupport=true 的条件支撑连接器和带有 useSupport=false 的条件固定模型）" 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  flange.f = f;
  flange.s = s;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={Text(
              extent={{-200,80},{200,40}}, 
              textColor={0,0,255}, 
              textString="%name"),Rectangle(
              extent={{-20,20},{20,-20}}, 
              lineColor={0,127,0}, 
              fillColor={175,190,175}, 
              fillPattern=FillPattern.Solid)}), Documentation(info="<html><p>
这是一个适配器模型，用于在组件中利用条件<a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.Support\" target=\"\">support connector</a>。 它可以应用于基于文本（基于方程的）和基于图形定义的组件：
</p>
<ul><li>
如果 <em>useSupport = true</em>，则该一维平动接口必须连接到条件支撑连接器。</li>
<li>
如果 <em>useSupport = false</em>，则该一维平动接口必须连接到条件固定模型。</li>
</ul><p>
变量 <strong>f</strong> 被定义为 <strong>input</strong>。在使用此模型在基于文本的组件中时，必须将其提供为修饰符，并通过力平衡进行计算。 这种内部支撑的方法通过以下部分模型实现：
</p>
<ul><li>
<a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialOneFlangeAndSupport\" target=\"\">PartialOneFlangeAndSupport</a>,</li>
<li>
<a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialTwoFlangesAndSupport\" target=\"\">PartialTwoFlangesAndSupport</a>,</li>
<li>
<a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialElementaryRotationalToTranslational\" target=\"\">PartialElementaryRotationalToTranslational</a>.</li>
</ul><p>
注意，支撑位置始终可以作为 internalSupport.s 访问，支撑力始终可以作为 internalSupport.f 访问。
</p>
</html>"));
end InternalSupport;