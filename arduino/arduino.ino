int potPin = A0;
int LDRPin = A2;
int btnPin = 2;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(btnPin, INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  
  int potVal = analogRead(potPin);
  int LDRVal = analogRead(LDRPin);
  int btnVal = digitalRead(btnPin);
  
  String stringDiv = ";";
  String print_val = potVal + stringDiv + LDRVal + stringDiv + btnVal;

  Serial.println(print_val);
  delay(150);
}
