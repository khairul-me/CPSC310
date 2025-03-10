// Author: Chris fietkiewicz.
// Description: Demonstrates file output in Processing using PrintWriter. Note that the path is hardcoded and should be changed to work in your file system.
import java.io.*;
import java.util.*;

PrintWriter result;
try {  // Create the output stream.
  // Create a file with a hardcoded path. Processing will not automatically use the directory where
  result = new PrintWriter("/Users/fietkiewicz/Desktop/_310/assignments/2/data.txt");
  result.println("Hello file.");
}
catch (FileNotFoundException e) {
  System.out.println("Can't open file.");
  System.out.println("Error: " + e);
  return;        // End the program.
}
result.close();
System.out.println("Done");
