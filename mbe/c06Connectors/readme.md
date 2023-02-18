
A connector is a language feature in Modelica that allows for the definition of a set of pins or interface points to a component. Connectors provide a way to explicitly define the external interface to a component and can be used to specify how that component interacts with the rest of the system.

A connector is defined by a set of pins, each of which can have a name, a type and a flow direction. The type of a pin can be any Modelica class, and the flow direction specifies whether the pin is an input, output or bidirectional.

The mathematical basis for connectors is based on the notion of bond graph modeling, which is a graphical modeling technique used in engineering to model physical systems. The pins in a connector correspond to the bonds in a bond graph, which represent the flow of energy or signals between components in the system.

Using connectors, we can define the external interface of a component in a standardized way, which allows for easy connection to other components in the system. This promotes modularity and reusability, as components can be easily connected and disconnected from the system without the need for extensive modifications to the models.