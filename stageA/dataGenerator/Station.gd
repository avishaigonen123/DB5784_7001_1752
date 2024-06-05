
[General]
Version=1

[Preferences]
Username=
Password=2464
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=C##AVISHAI
Name=STATION
Count=400

[Record]
Name=STATIONID
Type=NUMBER
Size=
Data=Sequence(1 [1], [400])
Master=

[Record]
Name=STATIONNAME
Type=VARCHAR2
Size=100
Data='Station ' + LastName
Master=

[Record]
Name=STATIONADDRESS
Type=VARCHAR2
Size=255
Data=Address1
Master=

