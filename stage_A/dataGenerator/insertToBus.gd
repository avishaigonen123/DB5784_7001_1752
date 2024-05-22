
[General]
Version=1

[Preferences]
Username=
Password=2656
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=BUS
Count=400

[Record]
Name=BUSID
Type=NUMBER
Size=38
Data=Sequence(1, [1], [600])
Master=

[Record]
Name=MODEL
Type=VARCHAR2
Size=100
Data=List('model1', 'model2', 'model3', 'model4', 'model5', 'model6', 'model7', 'model8', 'model9', 'model10')
Master=

[Record]
Name=CAPACITY
Type=NUMBER
Size=38
Data=Random(5, 38)
Master=

[Record]
Name=PURCHASEDATE
Type=DATE
Size=
Data=Random(04/04/2024, 04/11/2024)
Master=


[Table]
Owner=SYS
Name=DRIVER
Count=400

[Record]
Name=DRIVERID
Type=NUMBER
Size=38
Data=Sequence(1, [1], [600])
Master=

[Record]
Name=FULLNAME
Type=VARCHAR2
Size=100
Data=FirstName+' '+LastName
Master=

[Record]
Name=LICENSENUMBER
Type=VARCHAR2
Size=50
Data=Sequence(1, [100], [1000000])
Master=

[Record]
Name=HIREDATE
Type=DATE
Size=
Data=Random(09/11/2001, 09/11/2023)
Master=


[Table]
Owner=SYS
Name=ROUTE
Count=400

[Record]
Name=ROUTEID
Type=NUMBER
Size=38
Data=Sequence(1, [1], [600])
Master=

[Record]
Name=ROUTENAME
Type=VARCHAR2
Size=100
Data=FirstName+Random(1, 1000)
Master=

[Record]
Name=STARTSTATIONID
Type=NUMBER
Size=38
Data=Random(1,399)
Master=

[Record]
Name=ENDSTATIONID
Type=NUMBER
Size=38
Data=Random(1,399)
Master=


[Table]
Owner=SYS
Name=TRIP
Count=400

[Record]
Name=TRIPID
Type=NUMBER
Size=38
Data=Sequence(1, [1], [600])
Master=

[Record]
Name=BUSID
Type=NUMBER
Size=38
Data=Sequence(1, [1], [600])
Master=

[Record]
Name=DRIVERID
Type=NUMBER
Size=38
Data=Sequence(1, [1], [600])
Master=

[Record]
Name=TRIPDATE
Type=DATE
Size=
Data=Random(09/11/2001, 09/11/2023)
Master=

[Record]
Name=ROUTEID
Type=NUMBER
Size=38
Data=Sequence(1, [1], [600])
Master=

