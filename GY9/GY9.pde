Camera camera;

ParamSphere sphere = new ParamSphere();
ParamCylinder cylinder = new ParamCylinder();
ParamWave wave = new ParamWave();

PShape boat;
SpaceShip ship;

PImage tex_earth;
PImage tex_csirke;
PImage tex_texture;

void setup() {
  size(800, 600, P3D);
  
  tex_earth = loadImage("earth.jpg");
  tex_csirke = loadImage("csirke.jpg");
  tex_texture = loadImage("texture.bmp");
  
  boat = loadShape("OldBoat.obj");
  ship = new SpaceShip(loadShape("space_frigate.obj"));
  
  sphere.tex = tex_earth;
  cylinder.tex = tex_csirke;
  wave.tex = tex_texture;
  
  camera = new Camera();
}

void update() {
 camera.update(); 
 ship.update();
}

void keyReleased() {
   if (key == 'w') {
    camera.MoveForwad(false); 
   } else if (key == 's') {
    camera.MoveBackward(false); 
   } else if (key == 'd') {
    camera.MoveRight(false); 
   } else if (key == 'a') {
    camera.MoveLeft(false); 
   }
   
  if(keyCode == UP) {
   ship.MoveForward(false); 
  } else if(keyCode == DOWN) {
   ship.MoveBackward(false); 
  } else if(keyCode == LEFT) {
   ship.RotateLeft(false);
  } else if(keyCode == RIGHT) {
   ship.RotateRight(false);
  }
}


void keyPressed() {
 if (key == 'w') {
  camera.MoveForwad(true); 
 } else if(key == 's') {
   camera.MoveBackward(true);
 } else if (key == 'd') {
  camera.MoveRight(true); 
 } else if (key == 'a') {
  camera.MoveLeft(true); 
 }
  
  
  if(keyCode == UP) {
   ship.MoveForward(true); 
  } else if(keyCode == DOWN) {
   ship.MoveBackward(true);
  } else if(keyCode == LEFT) {
   ship.RotateLeft(true);
  } else if(keyCode == RIGHT) {
   ship.RotateRight(true);
  }
}

void draw() {
  update();
  SetLights();  
  draw3D();
}

void SetLights() {
  lights();
  directionalLight(0, 30, 200, 0, -1, 0);
}

void draw3D() {
  background(127);
  
  pushMatrix();
    rotateZ(millis()/1000.0);
    translate(0, 0, -1);
    pyramid();
    rotateY(PI);
    pyramid();
  popMatrix();
  
  pushMatrix();
    rotateZ(millis()/1000.0);
    translate(0, 0, 1);
    pyramid();
    rotateY(PI);
    pyramid();
  popMatrix();
  
  
  pushMatrix();
    rotateZ(-millis()/400.0);
    scale(1, 0.4, 0.4);
    translate(1,0,0);
    rotateY(PI/2);
    pyramid();
    rotateY(PI);
    pyramid();
  popMatrix();
  
  
  pushMatrix();
    translate(5, 0, 0);
    sphere.Draw();
  popMatrix();
  
  
  pushMatrix();
    translate(-5, 0, 0);
    cylinder.Draw();
  popMatrix();
  
  
  pushMatrix();
    translate(5, 5, 0);
    wave.offset.x = millis() / 500.0f;
    wave.offset.y = millis() / 500.0f;
    wave.Draw();
    
    PVector pos = wave.GetPos(0.5, 0.5);
    
    PVector normal = wave.GetNormal(0.5, 0.5);
    PVector du = wave.GetDiffU(0.5, 0.5);
    PVector dv = wave.GetDiffV(0.5, 0.5);
    
    normal.normalize();
    du.normalize();
    dv.normalize();
    
    stroke(255, 0, 0);
    line(pos.x, pos.y, pos.z, 
        pos.x + normal.x, pos.y + normal.y, pos.z + normal.z);
        
    stroke(0, 255, 0);
    line(pos.x, pos.y, pos.z, 
        pos.x + du.x, pos.y + du.y, pos.z + du.z);
        
    stroke(0, 0, 255);
    line(pos.x, pos.y, pos.z, 
        pos.x + dv.x, pos.y + dv.y, pos.z + dv.z);
    noStroke();
    
    pushMatrix();
      translate(pos.x, pos.y - 0.02, pos.z);
      applyMatrix(
      du.x, normal.x, dv.x, 0,
      du.y, normal.y, dv.y, 0,
      du.z, normal.z, dv.z, 0,
      0, 0, 0, 1);
      scale(0.02);
      
      shape(boat);
    popMatrix();
  popMatrix();
  
  ship.Draw();
}
void pyramid() {
 beginShape(TRIANGLES); 
 vertex(-1, -1, 0);
 vertex(1, -1, 0);
 vertex(-1, 1, 0);
 
 vertex(1, -1, 0);
 vertex(1, 1, 0);
 vertex(-1, 1, 0);
 
 vertex(-1, -1, 0);
 vertex( 1, -1, 0);
 vertex(0, 0, 1);
 
 vertex(1, -1, 0);
 vertex( 1, 1, 0);
 vertex(0, 0, 1);
 
 vertex(1, 1, 0);
 vertex( -1, 1, 0);
 vertex(0, 0, 1);
 
 vertex(-1, 1, 0);
 vertex( -1, -1, 0);
 vertex(0, 0, 1);
 endShape();
}
