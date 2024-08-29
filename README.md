# Torus

This project demonstrates how to create an animated 3D torus (or donut) that rotates and is displayed in the terminal using ASCII characters.
The animation is achieved by projecting a 3D shape onto a 2D plane and simulating lighting to create the illusion of depth and rotation.


https://github.com/user-attachments/assets/04126102-cd2a-4a6a-9945-3023bb76fe0c


## Installation

1. Clone this repository:

   ```sh
   git clone https://github.com/ZK1569/Torus.git
   cd Torus
   ```

2. Build the project using Zig:

   ```sh
   zig run src/main.zig
   ```

## Usage

Simply run the executable in your terminal:
The torus will start rotating and be displayed in ASCII characters directly in your terminal.

## How It Works

The project is based on the mathematical principles outlined in Andy Sloane's article. The core idea is to project a 3D torus onto a 2D plane and simulate lighting based on the angle of the surface relative to a light source.

The steps include:

- 3D Projection: Converting 3D coordinates of points on the torus to 2D coordinates for terminal display.
- Rotation: Applying rotation matrices to simulate the torus spinning around its axes.
- Lighting: Calculating brightness values for each point on the torus based on its angle to a simulated light source.
- Rendering: Displaying the torus in the terminal using ASCII characters to represent different brightness levels.
