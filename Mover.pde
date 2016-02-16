class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  
   
  float topSpeed;
  float mass;
  float radiusFactor = 16;
  float diameter;
  float radius;
  float elasticity = 0.8;
  
  Mover () {
    
    this.location = new PVector (random (width), random (height));    
    this.velocity = new PVector (0, 0);
    this.acceleration = new PVector (0 , 0);
    
    this.mass = 1;
    
    setRadius();
  }
  
  private void setRadius() {
    this.diameter = mass * radiusFactor;
    this.radius = diameter / 2;
  }
  
  Mover (PVector loc, PVector vel) {
    this.location = loc;
    this.velocity = vel;
    this.acceleration = new PVector (0 , 0);
    
    this.topSpeed = 100;
    
  }
  
  Mover (float m, float x, float y) {
    
    location = new PVector (x, y);
    
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    
    mass = m;
    setRadius();
  }
  
  void update () {
    velocity.add (acceleration);
    location.add (velocity);

    acceleration.mult (0);
  }
  
  void display () {
    stroke (0);
    fill (127, 127, 127, 127);
    
    ellipse (location.x, location.y, diameter, diameter); // Dimension à l'échelle de la masse
  }
  
  void checkEdges() {
    if (location.x + radius > width) {
      location.x = width - radius;
      velocity.x *= -1;
    } else if (location.x < radius) {
      velocity.x *= -1;
      location.x = radius;
    }
    
    if (location.y + radius > height) {
      if (abs(velocity.y) > 0.05) {
        velocity.y *= -elasticity;
      } else {
        velocity.y = 0;
      }
        
      location.y = height - radius;
    }
  }
  
  
  void applyForce (PVector force) {
    PVector f = PVector.div (force, mass);
   
    this.acceleration.add(f);
  }
}