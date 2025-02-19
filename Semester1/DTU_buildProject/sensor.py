from machine import ADC, Pin, PWM
import time
import math

#Pins setup
sensor = ADC(Pin(4))
boardLED = PWM(Pin(13),freq=1, duty = 512)
pwm1 = PWM(Pin(12),freq = 100000, duty = 165)
button = Pin(27, Pin.IN)

sensor.ATTN_11DB

#Time setup
currentTime = time.time()
previousTime = currentTime + 1
zeroPoint = -1


sample = []


while True:
    if button.value() == 0:
        break
    if currentTime % 2 == 0 and currentTime != previousTime:
        if zeroPoint == -1:
            zeroPoint = currentTime
        for i in range(1000):
            sample.append(-math.log10(sensor.read_uv())) 
        print(f"{currentTime - zeroPoint} \t {sum(sample)/1000}\n")
        sample = []
    previousTime = currentTime
    currentTime = time.time()

boardLED.duty(0)
pwm1.duty(0)
