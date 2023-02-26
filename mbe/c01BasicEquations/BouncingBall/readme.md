To export a Modelica model as an FMU (Functional Mock-up Unit) using OpenModelica Compiler (OMC), you can follow these steps:

    Load the model in the OpenModelica Interactive Environment (OMShell) by running the command loadModel(BouncingBall).

    Translate the model to the Functional Mock-up Interface (FMI) standard by running the command translateModelFMU(BouncingBall, fmuType="CoSimulation"). This command will generate a new directory called BouncingBall.fmu in the current working directory.

The fmuType argument specifies the type of FMU to be generated. In this case, we are generating a Co-Simulation FMU, which allows the simulation of the model to be executed outside of the Modelica environment.

    Once the FMU has been generated, you can import it into any FMI-compatible tool or platform for simulation and analysis.

Note that before exporting a Modelica model as an FMU, it's important to ensure that the model is compatible with the FMI standard, which involves several requirements such as having only continuous-time variables, and providing an initial state for the simulation.