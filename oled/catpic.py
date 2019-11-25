import time,SSD1306
from PIL import Image
from PIL import ImageDraw
from PIL import ImageFont

disp = SSD1306.SSD1306_128_64(rst=None, i2c_bus=0, gpio=3)
#disp.begin()
disp.clear()
disp.display()
width = disp.width
height = disp.height
height = disp.height
padding = 2
shape_width = 20
top = padding
bottom = height-padding
x = padding
#image = Image.open('2.jpg')
#image=image.resize((128,64))
#gay=image.convert("1")
image = Image.new('1', (width, height))
gay=image
draw = ImageDraw.Draw(gay)
font=ImageFont.truetype('minecraftia/Minecraftia-Regular.ttf', 18)
font2=ImageFont.truetype('minecraftia/Minecraftia-Regular.ttf', 14)
draw.text((x, top),    'CH4          16Nm3',  font=font2, fill=255)
top+=20
draw.text((x, top),    'CH2O',  font=font2, fill=255)
draw.text((x+20, top+20),    '     0.05ppm',  font=font, fill=255)
# Display image.
disp.image(gay)
disp.display()