
            int gameScreen = 0;
            int yon=0;
            int yilanboyutu=10;
            int zaman;
            int yenilenyem;
            int[] yilanx= new int[2500];
            int[] yilany= new int[2500];
            int yemx=(round(random(47))+1)*8;
            int yemy=(round(random(47))+1)*8;
            float timepoint;
            float yempoint;
            float toplampoint;
            Timer startTimer;
            Timer goUp;
            boolean yenidenuret=true;
            boolean oyunubitir=false;
            PImage bg; 
                  
         
           
          void setup()
          {
            restart();
            size(400,400);  
            smooth();
            frameRate=60;
            startTimer=new Timer(60);
            goUp=new Timer(0);
            
            bg = loadImage("snake3.jpg");
            
            
            yenilenyem=0;
            zaman=0;
            
            textAlign(CENTER);
            
          }
          
          void draw()
          {
            if (gameScreen == 0) {
              initScreen();
          } else if (gameScreen == 1) {
            
            gameScreen();
            
            String yemstats="Yem Sayısı= "+str(yenilenyem);
            
            noStroke();
            fill(255);
            rect(10,370,textWidth(yemstats),12);
            
            fill(0);
            text(yemstats,50,380);
            timepoint=(goUp.getTime()*3.0);
            toplampoint=toplampoint+timepoint;
            
            if(zaman%1==0){
              String timerstats="Kalan Zaman: "+startTimer.getTime();
              noStroke();
              fill(255);
              rect(10,30,textWidth(timerstats)+2,12);
              fill(0);
              text(timerstats,100,40);
            }
            } else if (gameScreen == 2) {
           
              gameOverScreen();
           
            }
               
          }
          
          void keyPressed()                   
          {
            
            if (key == CODED)
            {
              if (keyCode == UP && yon!=270 && (yilany[1]-8)!=yilany[2])
              {
                yon=90;
              }
              if (keyCode == DOWN && yon!=90 && (yilany[1]+8)!=yilany[2])
              {
                yon=270;
              }if (keyCode == LEFT && yon!=0 && (yilanx[1]-8)!=yilanx[2])
              {
                yon=180;
              }if (keyCode == RIGHT && yon!=180 && (yilanx[1]+8)!=yilanx[2])
              {
                yon=0;
              }
              if (keyCode == SHIFT)
              {
                restart();
                startTimer.setTime(60);
              }
            }
          }
          
          void travel()
          {
            for(int i=yilanboyutu;i>0;i--)                    
            {
              
              
              if (i!=1)
              {
                yilanx[i]=yilanx[i-1];
                yilany[i]=yilany[i-1];
                
              }
              else
              {
                switch(yon)
                {
                  case 0:
                  yilanx[1]+=8;
                  
                  break;
                  case 90:
                  yilany[1]-=8;
                  
                  break;
                  case 180:
                  yilanx[1]-=8;
                  
                  break;
                  case 270:
                  yilany[1]+=8;
                  
                  break;
                }
                
              }
            }
            
          }
          
          void display()           
          {
            
            if (yilanx[1]==yemx && yilany[1]==yemy)
            {
              
              startTimer.setTime(startTimer.getTime()+10);
              yenilenyem+=1;
              yempoint=yenilenyem;
              toplampoint=toplampoint+yempoint;
              
              yilanboyutu+=round(random(3)+1);
              yenidenuret=true;
              while(yenidenuret)
              {
                yemx=(round(random(47))+1)*8;
                yemy=(round(random(47))+1)*8;
                for(int i=1;i<yilanboyutu;i++)
                {     
                  if (yemx==yilanx[i] && yemy==yilany[i])
                  {
                    startTimer.setTime(startTimer.getTime()+10);
                    yenilenyem+=1;
                    yempoint=yenilenyem;
                    toplampoint=toplampoint+yempoint;
                    timepoint=(goUp.getTime()*3);
                    toplampoint=toplampoint+timepoint;
              
                    yenidenuret=true;
                  }
                  else
                  {
                    yenidenuret=false;
                    i=1000;
                  }
                  
                }
              }
            }
            
            stroke(255,255,255);
            fill(0);
            rect(yilanx[1],yilany[1],8,8);
            fill(255);
            rect(yilanx[yilanboyutu],yilany[yilanboyutu],8,8);
            
            
            
            
            
          }
          
          void checkdead()         
          {
            
            
            for(int i=2;i<=yilanboyutu;i++)
            {
              
              if(startTimer.getTime()==0){
                fill(255);
                rect(125,125,160,100);
                fill(0);
                text("Süre BİTTİ",200,150);
                text("Score:  "+str(toplampoint/10)+"ve"+str(yenilenyem)+" kadar yem yendi.",200,175);
                text("Tekrar için SHIFT'e basın",200,200);
                oyunubitir=true;
              }
              if (yilanx[1]==yilanx[i] && yilany[1]==yilany[i])
              {
                fill(255);
                rect(125,125,160,100);
                fill(0);
                text("OYUN BİTTİ",200,150);
                text("Score:  "+str(toplampoint/10)+"ve"+str(yenilenyem)+" kadar yem yendi.",200,175);
                text("Tekrar için SHIFT'e basın",200,200);
                oyunubitir=true;
              }
              if (yilanx[1]>=(width-8) || yilany[1]>=(height-8) || yilanx[1]<=0 || yilany[1]<=0)
              {
                fill(255);
                rect(125,125,160,100);
                fill(0);
                text("OYUN BİTTİ",200,150);
                text("Score:  "+str(toplampoint/10)+"  ve  "+str(yenilenyem)+" kadar yem yendi.",200,175);
                text("Tekrar için SHIFT'e basın",200,200);
                oyunubitir=true;
              }
              
            }
            
           
            
          }
          void restart()        
          {
           
           background(255);
            yilanx[1]=200;
            yilany[1]=200;
            for(int i=2;i<1000;i++)
            {
              yilanx[i]=0;
              yilany[i]=0;
            }
            oyunubitir=false;
            background(255);
            yemx=(round(random(47))+1)*8;
            yemy=(round(random(47))+1)*8;
            yilanboyutu=10;
            zaman=0;
            yon=0;
            yenidenuret=true;
            timepoint=0;
            yempoint=0;
            toplampoint=0;
            yenilenyem=0;
          }
          void initScreen() {
           
          background(bg);
          textAlign(CENTER);
          fill(255,255,255);
          text("TIME’sNAKE",200, 360);
          fill(255,255,255);
          text("Enes Erdoğan",200, 370);
          text("Oyuna Başla",200, 380);         
          }
          void gameScreen() {
  
            if (oyunubitir)          
            {
            }
            
            else
            {
            zaman+=1;
            startTimer.countDown();
            goUp.countUp();
            fill(255,0,0);
            stroke(0);
            rect(yemx,yemy,8,8);
            fill(0);
            stroke(0);
            rect(0,0,width,8);
            rect(0,height-8,width,8);
            rect(0,0,8,height);
            rect(width-8,0,8,height); 
            
            if ((zaman % 5)==0)
            {
               
              travel();
              display();
              checkdead();              
            }
           
            }
}
void gameOverScreen() {
  exit();
}

public void mousePressed() {
  // if we are on the initial screen when clicked, start the game
  if (gameScreen==0) {
    startGame();
    background(255);
    
  }
}


void startGame() {
  gameScreen=1;
}
         
         
