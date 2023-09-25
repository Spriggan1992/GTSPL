str1$ = " "
J=0
y = 50

CODEPAGE 1251
DIRECTION 1
CLS
TEXT 10,10,"Arial.ttf",0,12,12,"Тест печати на русском/Test russian print"
FOR I=32 TO 255
str1$=str1$+CHR$(I) + " "
J=J+1
IF J=16 THEN GOSUB drawTEXT
NEXT

PRINT 1
END

drawTEXT:
TEXT 10,y,"Arial.ttf",0,12,12,str1$
str1$=" "
J=0
y=y+40
RETURN
EOP
TEST

