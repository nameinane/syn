DECLARE SUB MKFONT (FONT$, SCALEFONT$, UNIT%)
DECLARE SUB MKSQUARE (X1!, Y1!, X2!, Y2!, FILL%, UNIT%)
DECLARE SUB TRIM2DEC (CONTENT$)
DECLARE SUB AMOVE (X!, Y!, UNIT%)
DECLARE SUB POSTDEF (UNIT%)
DECLARE SUB rline (X!, Y!, UNIT%)
DEFSNG A-Z
FC% = 14: BC% = 1

'A% - first position of index, B% - length of index
'A1% - first position of FIRSTNAME, B1% - length of FIRSTNAME
'A2% - first position of LASTNAME, B2% - length of LASTNAME
'ANi% - first position of i%-th name of relative, BNi% - legnth of i%-th name of relative
'AT% - first position of title, BT% - length of title
'AF% - position of code(old - 0, new - 2 or 3, book - 1)
'AFN% - first position of the Family Name Field (BOOKNAME)
'AB% - position of code(T - Name in book, F - Name not in book)
'AH% - position of code(T - Holocaust in book, F - Holocaust not in book)

'A1% = 86: B1% = 20
'A2% = 106: B2% = 15
'AT% = 74: BT% = 12

A% = 66: B% = 6
AN1% = 2: BN1% = 20
AN2% = 22: BN2% = 15
AFN% = 122: BFN% = 100  '46
AF% = 121
AB% = 222 '168
AH% = 223 '169

' FOR M31400
OLD6 = 8
' FOR ALL
'OLD6 = 6

COLOR FC%, BC%
CLS
INFILE$ = "JCCH92.TXT"
OPEN "I", 1, INFILE$
UNIT% = 2
OUTFILE$ = "JCCH1.PST"
OPEN "O", UNIT%, OUTFILE$
CALL POSTDEF(UNIT%)
ACCTCNT% = 0
IF NOT EOF(1) THEN LINE INPUT #1, REC$
WHILE NOT EOF(1) 'AND ACCTCNT% < 2
   REDIM NAMES$(30, 3)
   Holocaust$ = "F"
   CNT% = 1
   INDEX$ = MID$(REC$, A%, B%)
   TMPINDX$ = INDEX$
   FAMILYN$ = RTRIM$(LTRIM$(MID$(REC$, AFN%, BFN%)))

   TILDAPos% = INSTR(FAMILYN$, "~") 
   IF TILDAPos% > 1 AND TILDAPos% < LEN(LTRIM$(RTRIM$(FAMILYN$))) THEN
      FAM1$ = RTRIM$(LEFT$(FAMILYN$, TILDAPos% - 1))
      FAM2$ = LTRIM$(MID$(FAMILYN$, TILDAPos% + 1))
      FAMILYN$ = FAM1$ + " " + FAM2$
   END IF
   TILDAPos% = INSTR(FAMILYN$, "~") 
   IF TILDAPos% > 1 AND TILDAPos% < LEN(LTRIM$(RTRIM$(FAMILYN$))) THEN
      FAM1$ = RTRIM$(LEFT$(FAMILYN$, TILDAPos% - 1))
      FAM2$ = LTRIM$(MID$(FAMILYN$, TILDAPos% + 1))
      FAMILYN$ = FAM1$ + " " + FAM2$
   END IF

   Holocaust$ = MID$(REC$, AH%, 1)

   NAMES$(CNT%, 1) = RTRIM$(LTRIM$(MID$(REC$, AN1%, BN1%)))
   NAMES$(CNT%, 2) = RTRIM$(LTRIM$(MID$(REC$, AN2%, BN2%)))
   NAMES$(CNT%, 3) = MID$(REC$, AB%, 1)
   IF NAMES$(CNT%, 1) = "" AND NAMES$(CNT%, 2) = "" THEN CNT% = CNT% - 1
   WHILE TMPINDX$ = INDEX$ AND NOT EOF(1)
      LINE INPUT #1, REC$
      TMPINDX$ = MID$(REC$, A%, B%)
      IF TMPINDX$ = INDEX$ THEN
         CNT% = CNT% + 1
         NAMES$(CNT%, 1) = RTRIM$(LTRIM$(MID$(REC$, AN1%, BN1%)))
         NAMES$(CNT%, 2) = RTRIM$(LTRIM$(MID$(REC$, AN2%, BN2%)))
         NAMES$(CNT%, 3) = MID$(REC$, AB%, 1)
         IF NAMES$(CNT%, 1) = "" AND NAMES$(CNT%, 2) = "" THEN CNT% = CNT% - 1
      END IF
   WEND

PICKMODE:

'@@@@@@@@@@@@@@
'This is goes only for second letter

   'here text
'   PRINT #UNIT%, " st"
'   PRINT #UNIT%, "newpath"

'   FONT$ = "Times-Bold"
'   SCALEFONT$ = "16"
'   CALL MKFONT(FONT$, SCALEFONT$, UNIT%)
'   XX = 4.25
'   YY = 10.5
'   CALL AMOVE(XX, YY, UNIT%)
'   PRINT #UNIT%, "(LAST  CHANCE  FOR  LISTING) center show"
'   YY = YY - .25
'   CALL AMOVE(XX, YY, UNIT%)
'   PRINT #UNIT%, "(IN  THE) center show"
'   YY = YY - .25
'   CALL AMOVE(XX, YY, UNIT%)
'   PRINT #UNIT%, "(JCCH  YIZKOR  BOOK  OF  REMEMBRANCE) center show"
'   SCALEFONT$ = "12"
'   CALL MKFONT(FONT$, SCALEFONT$, UNIT%)
'   YY = YY - .35
'   DYY = .17
'   XX = .75
'   CALL AMOVE(XX, YY, UNIT%)
'   PRINT #UNIT%, "(We have had an exceptional response to our request for participation in the JCCH Yizkor)  show"
'   YY = YY - DYY
'   CALL AMOVE(XX, YY, UNIT%)
'   PRINT #UNIT%, "(Book of Remembrance, and have extended the due date for listing until August 4, 1995.)  show"
'   YY = YY - 1.5 * DYY
'   CALL AMOVE(XX, YY, UNIT%)
'   PRINT #UNIT%, "(In case you missed the original mailing, the Yizkor Memorial Prayers will be printed)  show"
'   YY = YY - DYY
'   CALL AMOVE(XX, YY, UNIT%)
'   PRINT #UNIT%, "(together with the Book of Remembrance.  Donors as well as their departed loved ones)  show"
'   YY = YY - DYY
'   CALL AMOVE(XX, YY, UNIT%)
'   PRINT #UNIT%, "(will be listed.  You also will have an opportunity to pay tribute to the children lost)  show"
'   YY = YY - DYY
'   CALL AMOVE(XX, YY, UNIT%)
'   PRINT #UNIT%, "(in Holocaust.  The booklet will be used when Yizkor prayers are recited on Yom Kippur,)  show"
'   YY = YY - DYY
'   CALL AMOVE(XX, YY, UNIT%)
'   PRINT #UNIT%, "(Shemini Atzeret, the last day of Passover, and the second day of Shavuot.)  show"
'   YY = YY - 1.5 * DYY
'   CALL AMOVE(XX, YY, UNIT%)
'   PRINT #UNIT%, "(Please complete and return the form.  It is not possible to print names without your)  show"
'   YY = YY - DYY
'   CALL AMOVE(XX, YY, UNIT%)
'   PRINT #UNIT%, "(confirmation.) show"
'   PRINT #UNIT%, "1 setlinewidth"
'   YY = YY - DYY
'   CALL AMOVE(XX, YY, UNIT%)
'   CALL rline(7!, 0, UNIT%)
'' HERE

   PRINT #UNIT%, "newpath"
   FONT$ = "Helvetica"
   SCALEFONT$ = "10"
   CALL MKFONT(FONT$, SCALEFONT$, UNIT%)
   PRINT #UNIT%, ".2 setlinewidth"
   X = 6.5
   Y = 10
   CALL AMOVE(X, Y, UNIT%)
   PRINT #UNIT%, " (ACCOUNT # "; INDEX$; ") show"
   X = .75
   DX = 0: DY = .2
   CALL AMOVE(X, Y, UNIT%)
'   PRINT #UNIT%, " (Dear Barry:) show"
   ACCTCNT% = ACCTCNT% + 1
   LOCATE 5, 15: PRINT ACCTCNT%
   LOCATE 5, 25: PRINT INDEX$
   Y = Y - 2 * DY
   CALL AMOVE(X, Y, UNIT%)
   PRINT #UNIT%, " (Please include the names of the following departed members of my \(our\) family) show"
   Y = Y - DY
   CALL AMOVE(X, Y, UNIT%)
   PRINT #UNIT%, " (\(" + FAMILYN$ + "\) in the JCCH Yizkor Book of Remembrance:) show"
   Y = Y - DY
   CALL AMOVE(X, Y, UNIT%)
   PRINT #UNIT%, " (\(The names listed in bold type appeared in last year's Yizkor Book\)) show"
   DX = 2.5

   FOR I% = 1 TO CNT%


      IF UCASE$(NAMES$(I%, 3)) = "T" THEN
         CALL MKFONT("Times-Bold", "10", UNIT%)
      ELSE
         CALL MKFONT(FONT$, SCALEFONT$, UNIT%)
      END IF
      IF I% MOD OLD6 = 0 THEN
         COL% = I% / OLD6 - 1: STR% = OLD6
      ELSE
         COL% = INT(I% / OLD6): STR% = I% - OLD6 * COL%
      END IF
      Y0 = Y - STR% * DY: X0 = X + COL% * DX
      CALL STRIPBLANKS(NAMES$(I%, 1), 3, FX%)
      IF FX% <> 0 THEN NAMES$(I%, 1) = LEFT$(NAMES$(I%, 1), FX%)
      CALL STRIPBLANKS(NAMES$(I%, 2), 3, FX%)
      IF FX% <> 0 THEN NAMES$(I%, 2) = LEFT$(NAMES$(I%, 2), FX%)
      CALL AMOVE(X0, Y0, UNIT%)
      PRINT #UNIT%, " ("; NAMES$(I%, 1); " "; NAMES$(I%, 2); ") show"
      X1 = X0 - .22
      CALL MKSQUARE(X1, Y0, X1 + .15, Y0 + .15, FILL%, UNIT%)
   NEXT I%

   CALL MKFONT("Helvetica", "10", UNIT%)
   FOR I% = CNT% + 1 TO 24      '18  - OLD FOR ALL < 18
      IF I% MOD OLD6 = 0 THEN
         COL% = I% / OLD6 - 1: STR% = OLD6
      ELSE
         COL% = INT(I% / OLD6): STR% = I% - OLD6 * COL%
      END IF
      Y0 = Y - STR% * DY: X0 = X + COL% * DX
      CALL AMOVE(X0, Y0, UNIT%)
      IF I% - CNT% = 1 THEN


         IF Holocaust$ = "T" THEN
            CALL MKFONT("Times-Bold", "10", UNIT%)
         ELSE
            CALL MKFONT(FONT$, SCALEFONT$, UNIT%)
         END IF

         PRINT #UNIT%, " (Holocaust Memorial) show"
         X1 = X0 - .22


         CALL MKFONT("Helvetica", "10", UNIT%)
         CALL MKSQUARE(X1, Y0, X1 + .15, Y0 + .15, FILL%, UNIT%)

      ELSEIF I% - CNT% = 2 THEN


         CALL MKFONT("Helvetica", "8", UNIT%)
         PRINT #UNIT%, " (Please print additional names) show"
      ELSE
         CALL rline(2.25, 0, UNIT%)
      END IF
   NEXT I%

   PRINT #UNIT%, " cp"
   PRINT #UNIT%, " st"
   PRINT #UNIT%, " newpath"
   Y = Y0 - 2 * DY
   CALL AMOVE(X, Y, UNIT%)
   CALL MKFONT("Helvetica", "10", UNIT%)

   PRINT #UNIT%, " (Enclosed is my \(our\) $18 per name contribution.) show"
   Y = Y - DY
   CALL AMOVE(X, Y, UNIT%)
   PRINT #UNIT%, " (Number of names ________ x $18 = $ ___________.) show  "
   Y = Y - 1.5 * DY
   CALL AMOVE(X, Y, UNIT%)
   PRINT #UNIT%, " (Additionally, I \(we\) are making the following) show"
   Y = Y - DY
   CALL AMOVE(X, Y, UNIT%)
   PRINT #UNIT%, " (contribution to the JCCH Yizkor Fund. ) show"
   CALL MKFONT("Helvetica", "8", UNIT%)
   PRINT #UNIT%, " ( \(This is not the Kol Nidre Fund.\)) show"
   CALL MKFONT("Helvetica", "10", UNIT%)
   Y = Y - 1.5 * DY
   CALL AMOVE(X, Y, UNIT%)
   PRINT #UNIT%, " (______ $25          _____ $100) show"
   Y = Y - 1.5 * DY
   CALL AMOVE(X, Y, UNIT%)
   PRINT #UNIT%, " (______ $50          _____ $150) show"
   Y = Y - 1.5 * DY
   CALL AMOVE(X, Y, UNIT%)
   PRINT #UNIT%, " (______ $75          _____ other          $ ________ check enclosed) show"
   Y = Y - 2 * DY
   CALL AMOVE(X, Y, UNIT%)
   PRINT #UNIT%, " (This is how your name will appear      " + FAMILYN$ + ") show"
   Y = Y - 2 * DY
   CALL AMOVE(X, Y, UNIT%)
   PRINT #UNIT%, " (Please correct if needed: __________________________________________) show"
   Y = Y - 2 * DY
   CALL AMOVE(X, Y, UNIT%)
   PRINT #UNIT%, " (Signature  ___________________________________.     ACCOUNT # " + INDEX$ + ") show"
   Y = Y - 2 * DY
   PRINT #UNIT%, "cp"
   PRINT #UNIT%, "newpath"
   CALL AMOVE(X, Y, UNIT%)
   PRINT #UNIT%, "2 setlinewidth"
   CALL rline(7, 0, UNIT%)
   'Y = Y - 1.5 * DY
   'CALL AMOVE(X, Y, UNIT%)
   'PRINT #UNIT%, " (Refold entire letter so that the return address printed below) show"
   'Y = Y - 1.5 * DY
   'CALL AMOVE(X, Y, UNIT%)
   'PRINT #UNIT%, " (              shows through reply envelope window.) show"
   'Y = Y - 1.5 * DY
   'CALL AMOVE(X, Y, UNIT%)
   'CALL RLINE(7, 0, UNIT%)
   Y = Y - 2 * DY
   CALL AMOVE(X, Y, UNIT%)
   PRINT #UNIT%, " (Please return before July 18, 2012 to ensure publication to) show"
   Y = Y - 2 * DY
   X = 1.5
   CALL AMOVE(X, Y, UNIT%)
   PRINT #UNIT%, " (JEWISH COMMUNITY CENTER OF HARRISON) show"
   Y = Y - 1.5 * DY
   CALL AMOVE(X, Y, UNIT%)
   'PRINT #UNIT%, " (130 UNION AVENUE) show"
   PRINT #UNIT%, " (130 UNION AVENUE) show"
   Y = Y - 1.5 * DY
   CALL AMOVE(X, Y, UNIT%)
   'PRINT #UNIT%, " (HARRISON, N.Y. 10528) show"
   PRINT #UNIT%, " (HARRISON, N.Y. 10528) show"
   PRINT #UNIT%, " cp"
   PRINT #UNIT%, " st"
   PRINT #UNIT%, " showpage"
   ERASE NAMES$
WEND
PRINT #UNIT%, CHR$(4)
CLOSE #UNIT%
'CALL EXIST(OUTFILE$, FX%)
'IF FX% THEN
'   DOSCMD$ = "COPY " + OUTFILE$ + " LPT1 > \DEV\NUL"
'   SHELL DOSCMD$
'   DOSCMD$ = "ERASE " + OUTFILE$
'   SHELL DOSCMD$
'END IF
CLOSE
END

SUB ALINE (X, Y, UNIT%)
'DRAW LINE FROM CURRENT POSITION TO POINT X,Y
TMPX = INT(X * 1000) / 1000
TMPX = TMPX * 72
X$ = STR$(TMPX)
CALL TRIM2DEC(X$)
TMPY = INT(Y * 1000) / 1000
TMPY = TMPY * 72
Y$ = STR$(TMPY)
CALL TRIM2DEC(Y$)
PRINT #UNIT%, X$; " "; Y$; " l"
END SUB

SUB AMOVE (X, Y, UNIT%)
'MOVE FROM CURRENT POSITION TO POINT X,Y
TMPX = INT(X * 1000) / 1000
TMPX = TMPX * 72
X$ = STR$(TMPX)
CALL TRIM2DEC(X$)
TMPY = INT(Y * 1000) / 1000
TMPY = TMPY * 72
Y$ = STR$(TMPY)
CALL TRIM2DEC(Y$)
PRINT #UNIT%, X$; " "; Y$; " m"
END SUB

SUB MKFONT (FONT$, SCALEFONT$, UNIT%)
'SETS THE CURRENT FONT AND WRITES IT TO THE POSTSCRIPT FILE
'SPECIFIED BY UNIT%
PRINT #UNIT%, "/" + FONT$ + " findfont " + SCALEFONT$ + "  scalefont setfont"
END SUB

SUB MKSQUARE (X1, Y1, X2, Y2, FILL%, UNIT%)
TMPX1 = INT(X1 * 1000) / 1000
XX = 72 * TMPX1
TMPY1 = INT(Y1 * 1000) / 1000
XX3 = 72 * TMPY1
TMPX2 = INT(X2 * 1000) / 1000
XX4 = 72 * TMPX2
TMPY2 = INT(Y2 * 1000) / 1000
XX2 = 72 * TMPY2
A$ = STR$(XX)
CALL TRIM2DEC(A$)
B$ = STR$(XX2)
CALL TRIM2DEC(B$)
D$ = STR$(XX3)
CALL TRIM2DEC(D$)
E$ = STR$(XX4)
CALL TRIM2DEC(E$)
PRINT #UNIT%, B$; " "; E$; " "; D$; " "; E$; " "; D$; " "; A$; " "; B$; " "; A$; " "; "abox"
IF FILL% = 1 THEN PRINT #UNIT%, ".25 setgray": PRINT #UNIT%, "fill"
END SUB

SUB POSTDEF (UNIT%)
SHARED WHICHDIR$
PRINT #UNIT%, CHR$(4)
PRINT #UNIT%, "newpath"
PRINT #UNIT%, "/m  { moveto} def"
PRINT #UNIT%, "/l  { lineto} def"
PRINT #UNIT%, "/cp  { closepath} def"
PRINT #UNIT%, "/st  { stroke} def"
PRINT #UNIT%, "/rlt  { rlineto} def"
PRINT #UNIT%, "/rmt  {rmoveto} def"
PRINT #UNIT%, "/abox {/x4 exch def"
PRINT #UNIT%, " /y4 exch def"
PRINT #UNIT%, " /x3 exch def"
PRINT #UNIT%, " /y3 exch def"
PRINT #UNIT%, " /x2 exch def"
PRINT #UNIT%, " /y2 exch def"
PRINT #UNIT%, " /x1 exch def"
PRINT #UNIT%, " /y1 exch def"
PRINT #UNIT%, "x1 y1 m"
PRINT #UNIT%, "x2 y2 l"
PRINT #UNIT%, "x3 y3 l"
PRINT #UNIT%, "x4 y4 l"
PRINT #UNIT%, "cp} def"
PRINT #UNIT%, "cp"
END SUB

SUB rline (X, Y, UNIT%)
'DRAW LINE FROM CURRENT POSITION TO POINT SHIFTED FOR X AND Y
'IN RESPOND DIRECTIONS
TMPX = INT(X * 1000) / 1000
TMPX = TMPX * 72
X$ = STR$(TMPX)
CALL TRIM2DEC(X$)
TMPY = INT(Y * 1000) / 1000
TMPY = TMPY * 72
Y$ = STR$(TMPY)
CALL TRIM2DEC(Y$)
PRINT #UNIT%, X$; " "; Y$; " rlt"
END SUB

SUB RMOVE (X, Y, UNIT%)
'MOVE FROM CURRENT POSITION FOR X AND Y IN RESPOND DIRECTIONS
TMPX = INT(X * 1000) / 1000
TMPX = TMPX * 72
X$ = STR$(TMPX)
CALL TRIM2DEC(X$)
TMPY = INT(Y * 1000) / 1000
TMPY = TMPY * 72
Y$ = STR$(TMPY)
CALL TRIM2DEC(Y$)
PRINT #UNIT%, X$; " "; Y$; " rmt"
END SUB

SUB TRIM2DEC (CONTENT$)
FORMAT$ = "############.##"
NUMBER# = VAL(CONTENT$)
OPEN "R", #200, "\DEV\NUL"                   ' open "null" device
FIELD #200, 128 AS REC$                      ' set up a field
PRINT #200, USING FORMAT$ + CHR$(0); NUMBER#; ' "print using" to field
CONTENT$ = LEFT$(REC$, INSTR(REC$, CHR$(0)) - 1)' extract results
CLOSE #200                                   ' close "null" device
CALL STRIPBLANKS(CONTENT$, 3, FL%)
IF FL% <> 0 THEN CONTENT$ = LEFT$(CONTENT$, FL%)
END SUB

