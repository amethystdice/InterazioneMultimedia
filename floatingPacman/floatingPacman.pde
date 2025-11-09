

int dim;
int start = 0;
int endscreen =0;
int numEnemy=5;
float closestEnemy; 
enemy[] e;
pacman p; 

class pacman{
    float posX = width/2;
    float posY = height/2;
    float speedX;
    float speedY;
    float pacmanSpeed= 50;

    void tick(){
        move();
        draw();
    }

    void move(){
        speedX = (mouseX-posX)/pacmanSpeed;
        speedY = (mouseY-posY)/pacmanSpeed;
        posX = posX + speedX;
        posY = posY + speedY;
    }

    void draw(){
        pushMatrix();
        // move origin to pacman's position, then rotate so the pacman faces movement direction
        translate(posX, posY);
        float ang = atan2(mouseY-posY,mouseX-posX);
        rotate(ang);


        stroke(0);
        strokeWeight(8);
        noFill();

        arc(0, 0, dim, dim,radians(45),radians(90),PIE);
        arc(0, 0, dim, dim,radians(270),radians(315),PIE);


        noStroke();
        fill(200,200,100);
        arc(0, 0, dim, dim,radians(45), radians(315),PIE);

        popMatrix();
    }
}

class enemy{
    float enemyPosX,enemyPosY,enemyTimer,enemyTimerUpdate;
    float enemySpeed = 3;
    boolean alive;

    enemy(){
        alive=true;
        enemyPosX=random(width);
        enemyPosY=((int)random(0.5,1.5)*height);
        enemyTimer = enemyTimerUpdate = random(10,20);
    }

    float tick(){
        if(alive){   
            timer();
            move();
            draw();
        }
        return eat();
    }

    void move(){
        if(enemyPosX>p.posX)
            enemyPosX=enemyPosX-enemySpeed*(random(0.5,1.5));
        else
            enemyPosX=enemyPosX+enemySpeed*(random(0.5,1.5));

        if(enemyPosY>p.posY)
            enemyPosY=enemyPosY-enemySpeed*(random(0.5,1.5));
        else
            enemyPosY=enemyPosY+enemySpeed*(random(0.5,1.5));

        enemySpeed=enemySpeed+0.001;
    }

    void draw(){
        pushMatrix();
        translate(enemyPosX,enemyPosY);

        noStroke();
        fill(255,0,0);
        circle(0,0,dim);

        stroke(0);
        strokeWeight(3);
        fill(0,200,0);
        arc(0,0,(dim/4)*3,(dim/4*3),HALF_PI-(PI*enemyTimerUpdate)/enemyTimer,HALF_PI+(PI*enemyTimerUpdate)/enemyTimer,CHORD);
        

        popMatrix();
    }

    void timer(){
        enemyTimerUpdate = enemyTimerUpdate-(0.016666);

        if(enemyTimerUpdate<0){
            enemyPosX=enemyPosY= Float.MIN_VALUE;
            alive=true;
        }
        
    }

    float eat(){
        float distance = dist(p.posX,p.posY,enemyPosX,enemyPosY);
        if(distance<dim){
            print("pacman got eaten");
            endscreen();
        }
        return distance;
    }
}




void setup(){
    //size(1000,1000);
    fullScreen();
    //frameRate(1);
    background(200,100,200);

    dim = 100;
    closestEnemy = width;

    p = new pacman();
    e = new enemy[numEnemy];
    
    for(int i=0;i<numEnemy;i++){
        e[i]= new enemy();
        print("X: ",e[i].enemyPosX," Y: ",e[i].enemyPosY,"\n");
    }
    
    //noLoop();
}

void draw(){

    //ending
    if(endscreen==1){
        delay(1000);
        exit();
    }

    //start
    if(start==0){
        apple(true);
        start=1;
        noLoop();
    }else{

        print(closestEnemy,"\n");
        if(closestEnemy<dim*2.5){
            fill (200,50,50,10);
        }
        else
            fill (100,150,100,10);
        rect(0,0,width,height);
        
        //creating entities
        p.tick();
        apple(false);

        closestEnemy = width;
        for(int i=0;i<numEnemy;i++){
            float tmp = e[i].tick();
            if(tmp<closestEnemy)
                closestEnemy=tmp;
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
    endscreen=1;
}

void apple(boolean start){

    float x,y;
    if(start==true){
        x = width/2;
        y = height/6;
    }
    else{
        x = mouseX;
        y = mouseY;
    }

    fill(0);
    noStroke();
    ellipse(x,y,50,50);

    if(dist(p.posX,p.posY,x,y)<dim/4){
        print("packman ate the apple");
        endscreen();
    }
}

void mouseClicked(){
    if(dist(width/2,height/6,mouseX,mouseY)<dim)
        loop();
}