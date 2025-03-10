// File I/O imports as used in the file_demo.pde
import java.io.*;
import java.util.*;

// Global variables
float angle = 0;
ArrayList<ArrayList<PVector>> slices = new ArrayList<ArrayList<PVector>>();

void setup() {
  size(800, 600, P3D);
  readBrainCoordinates();
}

void draw() {
  // Drawing approach from (cylinder tutorial)
  background(200);
  lights();
  translate(width/2, height/2, 0);
  rotateY(angle);
  angle += 0.01;
  
  // Draw cylinders for each slice (cylinder tutorial)
  for (int i = 0; i < slices.size(); i++) {
    drawCylinder(slices.get(i), i * 20);
  }
}

void readBrainCoordinates() {
  // File reading approach based on file_demo.pde as Prtof. Chris Provided
  BufferedReader reader;
  try {
    //  path technique from file_demo.pde
    reader = new BufferedReader(new FileReader("/C:/Users/khair/OneDrive/Documents/CPSC 310/HW 02/Problem2/brain_coordinates.txt"));
    String line;
    ArrayList<PVector> currentSlice = new ArrayList<PVector>();
    int currentImage = -1;
    
    //  shown in demo
    while ((line = reader.readLine()) != null) {
      // Comment handling as seen in brain_coordinates.txt format
      if (line.startsWith("#")) {
        if (currentSlice.size() > 0) {
          slices.add(currentSlice);
          currentSlice = new ArrayList<PVector>();
        }
        continue;
      }
      
      // file_demo.pde
      String[] parts = line.split(" ");
      if (parts.length >= 3) {
        int imageNum = Integer.parseInt(parts[0]);
        float x = Float.parseFloat(parts[1]);
        float y = Float.parseFloat(parts[2]);
        
        //
        if (currentImage != -1 && currentImage != imageNum) {
          slices.add(currentSlice);
          currentSlice = new ArrayList<PVector>();
        }
        
        currentImage = imageNum;
        // Center coordinates for display
        currentSlice.add(new PVector(x - 400, y - 300));
      }
    }
    
    // 
    if (currentSlice.size() > 0) {
      slices.add(currentSlice);
    }
    
    // file_demo.pde
    reader.close();
    System.out.println("Loaded " + slices.size() + " slices");
  }
  catch (Exception e) {
    // Error handling as shown in file_demo.pde
    System.out.println("Can't open file.");
    System.out.println("Error: " + e);
  }
}

void drawCylinder(ArrayList<PVector> points, float z) {
  // From that Drawing a Cylinder with Processing
  if (points.size() < 3) return;
  
  float cylinderHeight = 15;
  
  // QUAD_STRIP method from beginShape documentation and Drawing a Cylinder with Processing
  fill(255, 150, 0);
  stroke(255);
  beginShape(QUAD_STRIP); // Shape mode from beginShape() documentation
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    // Bottom and top vertices pattern from Drawing a Cylinder with Processing

    vertex(p.x, p.y, z);                  // Bottom vertex
    vertex(p.x, p.y, z + cylinderHeight); // Top vertex
  }
  // Complete the shape by connecting back to first point (as shown in Drawing a Cylinder with Processing)
  PVector first = points.get(0);
  vertex(first.x, first.y, z);
  vertex(first.x, first.y, z + cylinderHeight);
  endShape();
}

void keyPressed() {
  // common Processing technique
  if (key == 's') {
    saveFrame("brain-####.png");
    System.out.println("Screenshot saved");
  }
}
