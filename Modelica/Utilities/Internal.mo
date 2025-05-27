within Modelica.Utilities;
package Internal 
  "用户通常不应直接使用的内部组件"
  extends Modelica.Icons.InternalPackage;
  import Modelica.Units.SI;
partial package PartialModelicaServices 
    "需要特定工具实施的组件接口"
    extends Modelica.Icons.InternalPackage;
  package Animation "三维动画的模型和函数"
    extends Modelica.Icons.Package;
      partial model PartialShape "基本形状的三维动画接口"

        import Modelica.Mechanics.MultiBody.Frames;
        import Modelica.Mechanics.MultiBody.Types;

        parameter Types.ShapeType shapeType = "box" 
          "形状类型(box、球体、圆柱体、圆管、锥体、管道、梁、齿轮、弹簧, <external shape>)" annotation(Evaluate = true);
        input Frames.Orientation R = Frames.nullRotation() 
          "姿态对象，用于将世界坐标系旋转到体坐标系中" annotation(Dialog);
        input SI.Position r[3] = {0, 0, 0} 
          "从世界坐标系原点到体坐标系原点的位置矢量，在世界坐标系中解析" annotation(Dialog);
        input SI.Position r_shape[3] = {0, 0, 0} 
          "从体坐标系原点到形状原点的位置矢量，在体坐标系中解析" annotation(Dialog);
        input Real lengthDirection[3](each final unit = "1") = {1, 0, 0} 
          "长度方向上的矢量，在体坐标系中解析" annotation(Dialog);
        input Real widthDirection[3](each final unit = "1") = {0, 1, 0} 
          "宽度方向上的矢量，在体坐标系中解析" annotation(Dialog);
        input SI.Length length = 0 "视觉对象的长度" annotation(Dialog);
        input SI.Length width = 0 "视觉对象的宽度" annotation(Dialog);
        input SI.Length height = 0 "视觉对象的高度" annotation(Dialog);
        input Types.ShapeExtra extra = 0.0 
          "部分形状类型的附加尺寸数据" annotation(Dialog);
        input Real color[3] = {255, 0, 0} "形状颜色" annotation(Dialog(colorSelector = true));
        input Types.SpecularCoefficient specularCoefficient = 0.7 
          "环境光的反射(= 0：光被完全吸收)" annotation(Dialog);

        annotation(
          Documentation(info = "<html>
<p>
该模型在
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape\">Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape</a>
中有文档描述。</p>
</html>"      ));

      end PartialShape;

      model PartialVector "矢量(力、力矩等)的三维动画接口"
        import Modelica.Mechanics.MultiBody.Types;
        import Modelica.Mechanics.MultiBody.Frames;

        input Frames.Orientation R = Frames.nullRotation() 
          "姿态对象，用于将世界坐标系旋转到矢量坐标系中" annotation(Dialog);
        input SI.Position r[3] = {0, 0, 0} 
          "从世界坐标系原点到矢量坐标系原点的位置矢量，在世界坐标系中解析" annotation(Dialog);
        input Real coordinates[3] = {0, 0, 0} 
          "在矢量坐标系中解析的矢量坐标" annotation(Dialog);
        input Types.Color color = Types.Defaults.ArrowColor 
          "矢量的颜色" annotation(Dialog(colorSelector = true));
        input Types.SpecularCoefficient specularCoefficient = 0.7 
          "描述反射环境光的材料属性(= 0表示光被完全吸收)" annotation(Dialog);
        parameter Types.VectorQuantity quantity = Types.VectorQuantity.Force "坐标值所表示的量";
        input Boolean headAtOrigin = false "= true，如果矢量指向矢量坐标系的原点" annotation(Dialog);
        input Boolean twoHeadedArrow = false "= true, 如果矢量后面有两个箭头(指向同一方向)" annotation(Dialog);

        annotation(
          Documentation(info = "<html>
<p>
该模型在
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Vector\">Modelica.Mechanics.MultiBody.Visualizers.Advanced.Vector</a>
中有文档描述。</p>
</html>"      ));
      end PartialVector;

      model PartialSurface "曲面的三维动画接口"

        import Modelica.Mechanics.MultiBody.Frames;
        import Modelica.Mechanics.MultiBody.Types;

        input Frames.Orientation R = Frames.nullRotation() 
          "将世界坐标系旋转到曲面坐标系的姿态对象" 
          annotation(Dialog(group = "Surface frame"));
        input SI.Position r_0[3] = {0, 0, 0} 
          "从世界坐标系原点到曲面坐标系原点的位置矢量，在世界坐标系中解析" 
          annotation(Dialog(group = "Surface frame"));

        parameter Integer nu = 2 "u维中的点数" annotation(Dialog(group = "Surface properties"));
        parameter Integer nv = 2 "v维中的点数" annotation(Dialog(group = "Surface properties"));
        replaceable function surfaceCharacteristic = 
          Modelica.Mechanics.MultiBody.Interfaces.partialSurfaceCharacteristic 
          "定义表面特征的函数" 
          annotation(choicesAllMatching = true, Dialog(group = "Surface properties"));

        parameter Boolean wireframe = false "= true: 显示的3D模型将不带面孔" 
          annotation(Dialog(group = "Material properties"), choices(checkBox = true));
        parameter Boolean multiColoredSurface = false "= true: 为每个曲面点定义颜色" 
          annotation(Dialog(group = "Material properties"), choices(checkBox = true));
        input Real color[3] = {255, 0, 0} "表面颜色" annotation(Dialog(colorSelector = true, group = "Material properties", enable = not multiColoredSurface));
        input Types.SpecularCoefficient specularCoefficient = 0.7 
          "环境光的反射(= 0：光被完全吸收)" 
          annotation(Dialog(group = "Material properties"));
        input Real transparency = 0 "形状的透明度：0(=不透明)、......、 1(=完全透明)" 
          annotation(Dialog(group = "Material properties"));

        annotation(Documentation(info = "<html>
<p>
该模型在
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface\">Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface</a>
中有文档描述。</p>
</html>"      ));
      end PartialSurface;
    annotation();
  end Animation;

  package ExternalReferences "访问外部资源的函数"
    extends Modelica.Icons.InternalPackage;
    partial function PartialLoadResource 
        "工具特定函数接口，用于返回URI或本地文件名的绝对路径名"
      extends Modelica.Icons.Function;
      input String uri "URI或本地文件名";
      output String fileReference "文件的绝对路径名称";
      annotation (Documentation(info="<html>
<p>
此部分函数定义了在ModelicaServices包中工具特定实现的函数接口。该接口文档位于
<a href=\"modelica://Modelica.Utilities.Files.loadResource\">Modelica.Utilities.Internal.FileSystem.loadResource</a>。
</p>

</html>"        ));
    end PartialLoadResource;
    annotation();
  end ExternalReferences;

  package System "依赖于系统的函数"
    extends Modelica.Icons.InternalPackage;
      partial function exitBase "用于终止Modelica环境执行的特定工具函数接口"
        extends Modelica.Icons.Function;
        input Integer status = 0 "环境返回的结果(0表示成功)";
        annotation(Documentation(info = "<html>
<p>
此部分函数定义了在ModelicaServices包中工具特定实现的函数接口。
</p>
</html>"              ));
      end exitBase;
    annotation();
  end System;
    annotation (Documentation(info="<html>

<p>
中使用的一组函数和模型的接口
Modelica标准库需要<strong>工具特定的实现</strong>。
有一个关联的包叫做<strong>ModelicaServices</strong>。工具供应商
是否应提供相应的适当实现此库
工具。默认实现是“什么都不做”。
在Modelica标准库中，ModelicaServices的模型和函数
使用。
</p>
</html>"));
end PartialModelicaServices;

package FileSystem 
    "内部包，作为文件系统接口的外部函数"
 extends Modelica.Icons.InternalPackage;

  impure function mkdir "创建目录(POSIX: 'mkdir')"
    extends Modelica.Icons.Function;
    input String directoryName "创建新目录";
    annotation();
  external "C" ModelicaInternal_mkdir(directoryName) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaInternal.h\"", Library="ModelicaExternalC");
  end mkdir;

  impure function rmdir "删除空目录(POSIX function 'rmdir')"
    extends Modelica.Icons.Function;
    input String directoryName "要删除的空目录";
    annotation();
  external "C" ModelicaInternal_rmdir(directoryName) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaInternal.h\"", Library="ModelicaExternalC");
  end rmdir;

  impure function stat "查询文件信息(POSIX function 'stat')"
    extends Modelica.Icons.Function;
    input String name "文件、目录、管道等的名称";
    output Types.FileType fileType "Type of file";
    annotation();
  external "C" fileType = ModelicaInternal_stat(name) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaInternal.h\"", Library="ModelicaExternalC");
  end stat;

    impure function rename "重命名现有文件或目录(C函数'rename')"
      extends Modelica.Icons.Function;
      input String oldName "当前名称";
      input String newName "新名称";
      annotation();
    external "C" ModelicaInternal_rename(oldName, newName) annotation(IncludeDirectory = "modelica://Modelica/Resources/C-Sources", Include = "#include \"ModelicaInternal.h\"", Library = "ModelicaExternalC");
    end rename;

  impure function removeFile "删除现有文件(C函数'rename')"
    extends Modelica.Icons.Function;
    input String fileName "要删除的文件";
    annotation();
  external "C" ModelicaInternal_removeFile(fileName) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaInternal.h\"", Library="ModelicaExternalC");
  end removeFile;

  impure function copyFile 
      "复制现有文件(C函数'fopen', 'fread', 'fwrite', 'fclose')"
    extends Modelica.Icons.Function;
    input String fromName "要复制的文件名";
    input String toName "文件副本名称";
    annotation();
  external "C" ModelicaInternal_copyFile(fromName, toName) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaInternal.h\"", Library="ModelicaExternalC");
  end copyFile;

  function readDirectory 
      "读取目录名称(POSIX函数opendir, readdir, closedir)"
    extends Modelica.Icons.Function;
    input String directory 
        "所需信息的目录名称";
    input Integer nNames 
        "返回的文件名数量（通过 getNumberOfFiles 查询）";
    output String names[nNames] 
        "所有文件和目录名，从所需目录开始，顺序不限";
    annotation();
    external "C" ModelicaInternal_readDirectory(directory,nNames,names) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaInternal.h\"", Library="ModelicaExternalC");
  end readDirectory;

    function getNumberOfFiles 
      "获取目录中文件和目录的数量(POSIX函数opendir, readdir, closedir)"
      extends Modelica.Icons.Function;
      input String directory "目录名称";
      output Integer result 
        "'directory'中的文件和目录数量";
      annotation();
    external "C" result = ModelicaInternal_getNumberOfFiles(directory) annotation(IncludeDirectory = "modelica://Modelica/Resources/C-Sources", Include = "#include \"ModelicaInternal.h\"", Library = "ModelicaExternalC");
    end getNumberOfFiles;

  annotation (
Documentation(info="<html>
<p>
<strong>Internal.FileSystem</strong>包是一个内部包，包含作为文件系统接口的低级函数。
这些函数不应直接在脚本环境中调用，因为在Files和Systems包中提供了更便捷的函数。
</p>
<p>
请注意，本包中的函数是POSIX函数和标准C库函数的直接接口。
发生错误时，这些函数通过触发Modelica断言来处理。
因此，本包中的函数仅在操作成功时返回。
此外，这个接口隐藏了字符串的表示，特别是当操作系统支持Unicode字符时。
</p>
</html>"));
end FileSystem;
  annotation();
end Internal;