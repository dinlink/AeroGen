# AeroGen
AeroGen es un programa con interfaz gráfica para el diseño y análisis aerodinámico de turbinas eólicas de eje horizontal. Fue desarrollado en MATLAB por Abraham Vivas (ORCID: 0000-0003-4010-3883) durante su trabajo de fin de máster bajo la supervisión de Antonio Sánchez Káiser a finales de 2015. Entre las características disponibles se encuentran:
 - Cálculo de parámetros de ajuste de Weibull con calmas a partir de hoja de datos en excel
 - Estimación de tamaño de turbina para alimentar una instalación aislada (siguiendo el procedimiento enseñado durante el curso de ingeniería de sistemas eólicos impartido en la Universidad Politécnica de Cartagena) 
 - Diseño aerodinámico adimensional de la pala:
   + Permite el uso de perfiles en diferentes estaciones radiales, interpolando comportamientos intermedios.
   + Extensión del comportamiento de los perfiles entre -90 y 90 grados de ángulo de ataque
   + Incluye modelos de pérdidas en punta de palas
 - Análisis adimensional: Cálculo de la curva de coeficiente de potencia contra velocidad específica.
 - Análisis dimensional y optimización:  Determinación de el tamaño y velocidad de giro para la recuperación de energía dado un recurso eólico.
 
Documentación: presentación tutorial en el directorio "doc"
 
## Tomas de pantalla
Ventana principal de la aplicación

<img
src="https://raw.githubusercontent.com/dinlink/AeroGen/master/img/1_Main window.png" width="800">

<br>

Ventana de diálogo de carga de perfiles

<img
src="https://raw.githubusercontent.com/dinlink/AeroGen/master/img/2_Airfoil loading dialog.png" width="300">

<br>

Ventana de diálogo de extensión del comportamiento de perfiles

<img
src="https://raw.githubusercontent.com/dinlink/AeroGen/master/img/3_Airfoil extension dialog.png" width="600">

<br>

Ventana de diseño adimensional

<img
src="https://raw.githubusercontent.com/dinlink/AeroGen/master/img/4_Dimensionless design.png" width="800">

<br>

Ventana de análisis adimensional

<img
src="https://raw.githubusercontent.com/dinlink/AeroGen/master/img/5_Dimensionless analysis.png" width="800">

<br>

Ventana de optimización de dimensionado funcionando a velocidad fija

<img
src="https://raw.githubusercontent.com/dinlink/AeroGen/master/img/6_Fixed speed sizing optimization.png" width="800">
