import ddf.minim.*; 
Minim minim;
AudioPlayer song;

int bx = 0; //子彈座標
int by = 0; 
int [] px = new int[10]; //太空船隨機位置
int [] py = new int[10];
int [] sx = new int[10]; //太空船隨機位移值
int [] sy = new int[10];
int [] bs = new int[10]; //子彈速度值
int life = 4;
boolean isFire = false;
boolean isLife = true;
boolean isStart = true;
boolean isHit = false;
PImage img;
PImage shipImg;
PImage ship1Img;
PImage bImg;
int score = 0;
int timer = 200;
String [] str = new String[5];

void keyPressed() {
  isStart = false;
  switch(keyCode) {
  case SHIFT:
    life = 3;
    score = 0; 
    bx = 0;
    by = 0;
    isFire = false;
    isLife = true;
    timer = 200;
    for (int i = 0; i < 10; i++) {
      px[i] = (int)random(250);
      py[i] = (int)random(300);
      sx[i] = (int)random(250);
      sy[i] = (int)random(300);
      bs[i] = 0;
    }
    break;
  }
}

void build_ship(int a) {

  image(ship1Img, px[a] + sx[a], py[a], 80, 80);

  circle(px[a] + sx[a] + 40, py[a] + bs[a] + 40, 10); //sx[] random apper(應該要有負數),bs[] speed
  if ((py[a] + bs[a] + 20) > 560) {
    bs[a] = 0;
  } else {
    bs[a] += 5;
  }
}
void hit_ship(int a) {
    //if ((px[a] + sx[a] + 30) > (mouseX - 30 - 40) && (mouseX - 30 + 40) < (px[a] + sx[a] + 30) && (py[a] + bs[a] + 20) > 560) {
  //if ((px[a] + sx[a]) > (bx) && (bx) < (px[a] + sx[a] + 40) && (by) < py[a] + bs[a] + 40) {
    if ((px[a] + sx[a]) > (bx) && (bx) < (px[a] + sx[a] + 40)){
    life = life - 1;
  }
}


void hit_enemy_ship(int a) {
  if (bx > px[a] + sx[a] && bx < px[a] + 80 && by > py[a] && by < py[a] + 80) {
    isFire = false;
    score = score + 10;
    px[a] = (int)random(250);
    py[a] = (int)random(300);
  }
}

void setup() {
  size(500, 600);
  img = loadImage("space.jpg");
  shipImg = loadImage("ship.png");
  ship1Img = loadImage("ship1.png");
  for (int i = 0; i < 10; i++) {
    px[i] = (int)random(250);
    py[i] = (int)random(300);
    sx[i] = (int)random(250);
    sy[i] = (int)random(300);
    bs[i] = 0;
  }
}

void draw() {

  image(img, 0, 0, width, height);

  if (life > 0) {

    image(shipImg, mouseX-30, height-50, 100, 60); //space ship

    build_ship(0); //ship 1
    hit_ship(0);

    if (mousePressed == true) {
      isFire = true;
      bx = mouseX;
      by = height;
    }

    if (isFire) {
      print("py[0]="+py[0]);
      fill(255, 0, 0);
      circle(bx + 20, by - 30, 10);  //mouseX會使子彈亂跑
      by = by - 10;
      if (by < 0) {
        bx = mouseX;
        by = height;
       // isDisplay = false;
      }
    }

    if (timer < 0) {
      for (int i = 0; i < 3; i++) {
        sx[i] = (int)random(250);
        sy[i] = (int)random(300);
      }
      timer = 200;
    } else {
      timer--;
    }

    fill(255, 255, 0);
    str[0] = "Score : " + score + "  Life : "+life;
    textSize(10);
    textAlign(CENTER, CENTER);
    text(str[0], 50, 20);
  }
}
