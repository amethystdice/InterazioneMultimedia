
float posX;
float posY;
int dim;
int flag = 0;
int endscreen =0;
int numEnemy=5;
int start=0;
float[] enemyPosX = new float[numEnemy];
float[] enemyPosY = new float[numEnemy];
float[] enemyTimer = new float[numEnemy];
float[] enemyTimerUpdate = new float[numEnemy];
float enemySpeed = 5;
float pacmanSpeed= 50;



void setup(){
    fullScreen();
    background(200,100,200);
    posX = width/2;
    posY = height/2;
    dim = 100;

    for(int i=0;i<numEnemy;i++){
        enemyPosX[i]=random(width);
        enemyPosY[i]=((int)random(0.5,1.5)*height);
        enemyTimer[i]= enemyTimerUpdate[i] = random(10,20);
        print("X: ",enemyPosX[i]," Y: ",enemyPosY[i],"\n");
    }
    
    //noLoop();
}

void draw(){

    //ending
    if(endscreen==1){
        print("hello");
        exit();
    }

    //start
    if(flag==0){
        fill(255,0,0);
        strokeWeight(4);
        ellipse(width/2,height/6,50,50);
        flag=1;
        noLoop();
    }else{
        //float modifier = (enemyTimer[0]-enemyTimerUpdate[0])*10;
        fill (100,150,100,10);
        rect(0,0,width,height);
        

        apple();
        pacman();
        

        for(int i=0;i<numEnemy;i++)
            enemy(i);
    
        distanceChecker();
    }
}


void distanceChecker(){
    if(dist(posX,posY,mouseX,mouseY)<dim){
        print("packman ate the apple");
        endscreen();
    }

    for(int i=0;i<numEnemy;i++){
        if(dist(posX,posY,enemyPosX[i],enemyPosY[i])<dim){
            print("pacman got eaten");
            endscreen();
        }
    }
}

void endscreen(){
    fill(100,0,0);
    rect(width/4,height/4,(width/2),(height/2));
    textSize(200);
    textAlign(CENTER);
    fill(0);
    text("The End",width/2,height/2);
    delay(1000);
    endscreen=1;
}
void apple(){
    fill(255,0,0);
    strokeWeight(4);
    ellipse(mouseX,mouseY,50,50);

}

void enemy(int id){
    if(enemyTimerUpdate[id]<0){
        enemyPosX[id]=enemyPosY[id]= MAX_FLOAT;
        return;
    }

    if(enemyPosX[id]>posX)
        enemyPosX[id]=enemyPosX[id]-enemySpeed*(random(0.5,1.5));
    else
        enemyPosX[id]=enemyPosX[id]+enemySpeed*(random(0.5,1.5));

    if(enemyPosY[id]>posY)
        enemyPosY[id]=enemyPosY[id]-enemySpeed*(random(0.5,1.5));
    else
        enemyPosY[id]=enemyPosY[id]+enemySpeed*(random(0.5,1.5));

    enemySpeed=enemySpeed+0.001;
    
    pushMatrix();
    translate(enemyPosX[id],enemyPosY[id]);

    noStroke();
    fill(255,0,0);
    circle(0,0,dim);

    stroke(0);
    strokeWeight(3);
    fill(0,200,0);
    arc(0,0,(dim/4)*3,(dim/4*3),HALF_PI-(PI*enemyTimerUpdate[id])/enemyTimer[id],HALF_PI+(PI*enemyTimerUpdate[id])/enemyTimer[id],CHORD);
    

    popMatrix();


    enemyTimerUpdate[id] = enemyTimerUpdate[id]-(0.016666);


}

void pacman(){
    // update position
    float speedX = (mouseX-posX)/pacmanSpeed;
    float speedY = (mouseY-posY)/pacmanSpeed;
    posX = posX + speedX;
    posY = posY + speedY;

    pushMatrix();
    // move origin to pacman's position, then rotate so the pacman faces movement direction
    translate(posX, posY);
    float ang = atan2(speedY, speedX);
    rotate(ang);


    stroke(0);
    strokeWeight(8);
    noFill();

    arc(0, 0, dim, dim,radians(45),radians(90),PIE);
    arc(0, 0, dim, dim,radians(270),radians(315),PIE);
    //arc(0, 0, dim, dim,radians(45), radians(315),PIE);


    noStroke();
    fill(200,200,100);
    // draw arc centered at origin (0,0) so rotation affects it
    arc(0, 0, dim, dim,radians(45), radians(315),PIE);

    popMatrix();
}

void mouseClicked(){
    if(dist(width/2,height/6,mouseX,mouseY)<dim)
        loop();
}