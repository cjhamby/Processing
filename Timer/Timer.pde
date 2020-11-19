/*
 * Timeclock
 * by Chris Hamby
 * 
 * I want to be accurate with my time reporting
 * So I created this clock with a start/pause option
 *
 * I used this as an opportunity to practice formatting code
 * according to the convention at the following link:
 * 
 * https://www.oracle.com/technetwork/java/codeconventions-150003.pdf
 *
 */
 
static final int BG_COLOR = #33CCDD;

Clock myClock;

/* initial window and text configuration + clock instance */
void setup(){
  size(400,220);
  PFont myFont = loadFont("Rubik-Bold-50.vlw");
  textFont(myFont);
  textAlign(CENTER);
  rectMode(CENTER);
  
  myClock = new Clock();    /* clock instance */
}

void draw(){
  background(BG_COLOR);
  myClock.act();
}

void mouseClicked(){
  myClock.onClick(mouseX, mouseY);
}



public class Clock{
  private static final int CLOCK_Y      = 60;
  private static final int TEXT_SIZE    = 50;
  private static final int WIDTH        = 250;
  private static final int HEIGHT       = 80;
  private static final int BG_COLOR_ON  = 240; 
  private static final int BG_COLOR_OFF = 150;
  private static final int FONT_COLOR   = 0;
  
  private static final int PAUSE_BUTTON_X = 200;
  private static final int PAUSE_BUTTON_Y = 160;
  
  private int sec = 0;
  private int min = 0;
  private int hr  = 0;
  private String timeString = "00:00:00";
  
  public Button pauseButton;
  private int lastTimerVal = 0;
  private boolean isRunning = false;
  
  public Clock(){
    pauseButton = new Button(PAUSE_BUTTON_X, PAUSE_BUTTON_Y, "Pause");
  }
  
  private void display(){
    /* the background color shows the running status */
    if(isRunning) {
      fill(BG_COLOR_ON);
    }
    else {
      fill(BG_COLOR_OFF);
    }
    
    /* draw the background */
    rect(width/2, CLOCK_Y, WIDTH, HEIGHT);
    
    /* write the time */
    textSize(TEXT_SIZE);
    fill(FONT_COLOR);
    text(timeString, width/2, (CLOCK_Y + TEXT_SIZE/2) );
  }
  
  
  public void act(){
    runClock();
    this.display();
    pauseButton.display(); 
    
  }
  
  private void runClock(){
    if(!isRunning) return;         /* don't run if paused */
    if(second()!= lastTimerVal) {
      lastTimerVal = second();
      if(++sec >= 60){             /* increment seconds   */
        sec = 0;
        if(++min >= 60){           /* increment minutes   */
          min = 0;
          hr++;                    /* increment hours     */
        }
      }
      timeString = " " + hr + ":" + min + ":" + sec;
    }
    
  }
  
  
  /* called when the mouse is clicked anywhere */
  public void onClick(int x, int y){
    
    /* check for button presses */
    if(pauseButton.containsPoint(x,y)){
      isRunning = pauseButton.click(); 
      lastTimerVal = second();
    }
  }
  
  
}



public class Button{
  private static final int WIDTH       = 100;
  private static final int HEIGHT      =  50;
  private static final int TEXT_HEIGHT =  25;
  private static final int BG_COLOR  = #00E000; 
  private static final int TEXT_COLOR  = 255; 
  
  private int x, y;
  private boolean status;
  private String name;
  
  public Button(int x, int y, String name){
    this.x = x;
    this.y = y;
    this.name = name;
  }
  
  public void display(){
    fill(BG_COLOR);
    rect(x, y, WIDTH, HEIGHT);
    fill(TEXT_COLOR);
    textSize(TEXT_HEIGHT);
    text(name, x, (y + TEXT_HEIGHT/2) );  
  };
  
  
  /* returns whether (xx, yy) is in the button space 
   * (xx, yy) would generally be the 
   */
  public boolean containsPoint(float xx, float yy){
    if( xx > (x + WIDTH/2)   
        || xx < (x - WIDTH/2)   
        || yy > (y + HEIGHT/2) 
        || yy < (y - HEIGHT/2)) {
       return false;
     }
     
     return true;
  }
  
  /* the function called when the button is clicked */
  public boolean click(){
    status = !status;
    return status;
  }
}
