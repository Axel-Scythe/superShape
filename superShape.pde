import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

PeasyCam cam;

PVector[][] globe;
int total = 50;

float a = 1;
float b = 1;

float m = 0;
float change = 0;

void setup() {
  size (600, 600, P3D);
  cam = new PeasyCam(this, 500);
  colorMode(HSB);
  globe = new PVector[total+1][total+1];
}

float superShape(float theta, float m, float n1, float n2, float n3) {
  float t1 = abs((1 / a) * cos(m * theta / 4));
  t1 = pow(t1, n2);
  float t2 = abs((1 / b) * sin(m *theta / 4));
  t2 = pow(t2, n3);
  float t3 = t1 + t2;
  float r = pow(t3, -1 / n1);
  return r;
}

void draw() {
  background(75);
  noStroke();
  ambientLight(0,0,255);

  m = map(sin(change), 0, 1, 0, 7);
  change += 0.01;

  float r = 200;
  for (int i = 0; i < total+1; i++) {
    
    float lat = map(i, 0, total, -HALF_PI, HALF_PI);
    float r2 = superShape(lat, m, 0.2, 1.7, 1.7);

    for (int j = 0; j < total+1; j++) {
    
      float lon = map(j, 0, total, -PI, PI);
      float r1 = superShape(lon, m, 0.2, 1.7, 1.7);
      float x = r * r1 * cos(lon) * r2 *cos(lat);
      float y = r * r1 * sin(lon) * r2 *cos(lat);
      float z = r * r2 * sin(lat);
      
      globe[i][j] = new PVector(x, y, z);
    }
  }

  //stroke(255);
  //noFill();  
  for (int i = 0; i < total; i++) {
    beginShape(TRIANGLE_STRIP);
    for (int j = 0; j < total+1; j++) {
      float hu = map(i, 0, total, 0, 255*6);
      fill(hu % 255, 255, 255);
      PVector v1 = globe[i][j];
      vertex(v1.x, v1.y, v1.z);
      PVector v2 = globe[i+1][j];
      vertex(v2.x, v2.y, v2.z);
    }
    endShape();
  }
}