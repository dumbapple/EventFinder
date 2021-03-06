DROP TABLE WorkOn;
DROP TABLE EventHasType;
DROP TABLE InterestedIn;
DROP TABLE Friend;
DROP TABLE PayWith;
DROP TABLE Participate;
DROP TABLE PaidEvent;
DROP TABLE Sponsor;
DROP TABLE CreditCard;
DROP TABLE Event;
DROP TABLE Staff;
DROP TABLE Company;
DROP TABLE EventType;
DROP TABLE User;

CREATE TABLE User (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender VARCHAR(50) NOT NULL
);

CREATE TABLE CreditCard (
    CardNumber VARCHAR(16) PRIMARY KEY,
    ExpiryDate VARCHAR(10),
    HolderName VARCHAR(100) NOT NULL,
    CVC INT NOT NULL
);

CREATE TABLE Event (
    EventID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(200) NOT NULL,
    StartDate TIMESTAMP NOT NULL,
    EndDate TIMESTAMP NOT NULL,
    Description VARCHAR(200),
    LocationAddress VARCHAR(200),
    OrganizerUserID INT,
	OrganizerContactInfo VARCHAR(200),
    FOREIGN KEY (OrganizerUserID) REFERENCES User(UserID) ON DELETE SET NULL
);

CREATE TABLE PaidEvent (
    EventID INT PRIMARY KEY,
    Price INT NOT NULL,
    FOREIGN KEY (EventID) REFERENCES Event(EventID) ON DELETE CASCADE
);

CREATE TABLE Staff (
    StaffID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    PayRate INTEGER NOT NULL
);

CREATE TABLE Company (
    CompanyID INT PRIMARY KEY AUTO_INCREMENT,
    CompanyName VARCHAR(200) NOT NULL
);

CREATE TABLE Sponsor (
    EventID INT,
    CompanyID INT,
    RepresentativeName VARCHAR(100) NOT NULL,
    Budget INT NOT NULL,
    PRIMARY KEY (EventID, CompanyID),
    FOREIGN KEY (EventID) REFERENCES Event(EventID) ON DELETE CASCADE,
    FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID) ON DELETE CASCADE
);

CREATE TABLE EventType (
    TypeName VARCHAR(50) PRIMARY KEY,
    AgeLimit INT NOT NULL
);

CREATE TABLE WorkOn (
    StaffID INT,
    EventID INT,
    PRIMARY KEY (StaffID, EventID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID) ON DELETE CASCADE,
    FOREIGN KEY (EventID) REFERENCES Event(EventID) ON DELETE CASCADE
);

CREATE TABLE EventHasType (
    EventID INT,
    EventType VARCHAR(50),
    PRIMARY KEY (EventID, EventType),
    FOREIGN KEY (EventID) REFERENCES Event(EventID) ON DELETE CASCADE,
    FOREIGN KEY (EventType) REFERENCES EventType(TypeName) ON DELETE CASCADE
);

CREATE TABLE InterestedIn (
    UserID INT,
    EventType VARCHAR(50),
    PRIMARY KEY (UserID, EventType),
    FOREIGN KEY (UserID) REFERENCES User(UserID) ON DELETE CASCADE,
    FOREIGN KEY (EventType) REFERENCES EventType(TypeName) ON DELETE CASCADE
);

CREATE TABLE Friend (
    Friend1UserID INT,
    Friend2UserID INT,
    PRIMARY KEY (Friend1UserID, Friend2UserID),
    FOREIGN KEY (Friend1UserID) REFERENCES User(UserID) ON DELETE CASCADE,
    FOREIGN KEY (Friend2UserID) REFERENCES User(UserID) ON DELETE CASCADE
);

CREATE TABLE PayWith (
    UserID INT,
    CardNumber VARCHAR(16),
    primaryCard BIT NOT NULL,
    PRIMARY KEY (UserID, CardNumber),
    FOREIGN KEY (UserID) REFERENCES User(UserID) ON DELETE CASCADE,
    FOREIGN KEY (CardNumber) REFERENCES CreditCard(CardNumber) ON DELETE CASCADE
);

CREATE TABLE Participate (
    UserID INT,
    EventID INT,
    Status VARCHAR(50) NOT NULL,
    PRIMARY KEY (UserID, EventID),
    FOREIGN KEY (UserID) REFERENCES User(UserID) ON DELETE CASCADE,
    FOREIGN KEY (EventID) REFERENCES Event(EventID) ON DELETE CASCADE
);

INSERT INTO User VALUES (51, 'John', 'Smith', '1991-05-23', 'Male');
INSERT INTO User VALUES (52, 'Peter', 'Parker', '1991-06-02','Male');
INSERT INTO User VALUES (53, 'Tony', 'Stark', '1972-12-10','Male');
INSERT INTO User VALUES (54, 'Black', 'Widow', '1982-10-06','Female');
INSERT INTO User VALUES (55, 'Steve', 'Rogers', '1933-04-25','Male');
INSERT INTO Event VALUES(0, 'Comedy Club', '2020-04-15', '2020-04-17','Full of laughs','Beatty Street, Vancouver', 51, "51@eventfinder.com");
INSERT INTO Event VALUES(5, 'UFC Fight','2020-05-03','2020-05-03', 'McGreggor Vs Khalid', 'Gastown', 55, "55@eventfinder.com" );
INSERT INTO Event VALUES(2, 'Circus', '2020-04-23','2020-05-03','Cirque de Solil', 'Granville Street', 53, "53@eventfinder.com" );
INSERT INTO Event VALUES(3, 'Play', '2020-05-24','2020-06-07','Theatrical Play','Mainland Street', 52, "52@eventfinder.com" );
INSERT INTO Event VALUES(4, 'Drinking Challenge', '2020-06-07','2020-06-09', 'Beer Drinking Competition','Gastown',54, "54@eventfinder.com" );
insert into EventType values ('sports', 18);
insert into EventType values ('study', 0);
insert into EventType values ('group event', 14);
insert into EventType values('dining', 21);
insert into EventType values ('charity', 21);
insert into CreditCard values(1234567891233,'2020/06', 'Clarke Kent', '123');
insert into CreditCard values (9876543211234, '2024/12', 'Bruce Wayne','000');
insert into CreditCard values(4632850327091, '2020/01', 'Lex Luther', '233');
insert into CreditCard values(12343528357318,'2022/08', 'Martha Kent', '123');
insert into CreditCard values(3258238571048, '2021/06', 'Louis Layne', '455');                   
insert into PaidEvent values(5,49);
insert into PaidEvent values(2,27);
insert into PaidEvent values(3, 39);                
insert into  Company values(542154,'Coke');
insert into  Company values(985462,'Dell');
insert into  Company values(387568, 'RBC');
insert into  Company values(2345235, 'Samsung');
insert into  Company values(2143132, 'Apple'); 
insert into  Staff values(901, 'Shasha', 11);
insert into  Staff values(902, 'Loretta', 12);
insert into  Staff values(903, 'Tony', 20);
insert into  Staff values(904, 'Arvin', 33);
insert into  Staff values(905, 'David', 35); 
insert into Participate values (51, 3, 'Registered');
insert into Participate values (51, 4, 'Registered');
insert into Participate values (51, 5, 'Registered');
insert into Participate values (51, 1, 'Registered');
insert into Participate values (52, 1, 'Registered');
insert into Participate values (52, 2, 'Registered');
insert into Participate values (52, 3, 'Registered');
insert into Participate values (52, 4, 'Registered');
insert into Participate values (52, 5, 'Registered');
insert into Participate values (52, 0, 'Registered');
insert into Participate values (53, 1, 'Registered');
insert into Participate values (53, 2, 'Registered');
insert into Participate values (53, 5, 'Registered');
insert into Participate values (53, 0, 'Registered');
insert into Participate values (54, 1, 'Registered');
insert into Participate values (54, 2, 'Registered');
insert into Participate values (54, 5, 'Registered');
insert into Participate values (55, 1, 'Registered');
insert into Participate values (55, 3, 'Registered');
insert into Participate values (55, 5, 'Registered');
insert into Participate values (55, 0, 'Registered');
insert into PayWith values (51,1234567891233, 1);
insert into PayWith values (52,9876543211234, 1);
insert into PayWith values (53,4632850327091, 1);
insert into PayWith values (54, 12343528357318, 1);
insert into PayWith values (55,3258238571048, 1);
insert into workon values (901,4);
insert into workon values (902,3);
insert into workon values (903,1);
insert into workon values (904,5);
insert into workon values (905,1);
insert into sponsor values (5, 542154, 'Jimmy', 2500);
insert into sponsor values (1, 985462,'Paul', 1200);
insert into sponsor values (2, 387568,'Howard', 3500);
insert into sponsor values (3, 2345235,'Roger',  6500);
insert into sponsor values (4, 2143132,'Wallie',  10000);
insert into EventHasType values (2, 'sports');
insert into EventHasType values (2, 'study');
