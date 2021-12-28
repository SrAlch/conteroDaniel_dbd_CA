# ConteroDaniel_dbd_CA
Project created as first experience with SQL and Microsoft SQL Server on Dublin Business School. The Entity–relationship model can be found [here](#erm-(entity-relationship-model)) and the full project report [here](/conteroDaniel_technicalDocumentation_CA.pdf)

## Requirements
> ### Assessment Overview
>The assignment focuses on the technical design and provision of a new database server and the development of a new database for a Car Dealership accompanied with a Technical Design document. 
>### Assessment Task 
>A Car Dealership sells both new and used cars, and it operates a service facility. We know that a salesperson may sell many cars, but each car is sold by only one salesperson. For each car he or she sells a salesperson writes a single invoice. Every customer may buy many cars, but each car is bought by only one customer. With each purchase a customer receives an invoice. Customers details are recorded by the Dealership and periodically they review these as part of GDPR and ask customers via email/text message if they are happy for their details to remain in their system. If the customer wishes to be removed, the Dealership will remove only the personal information and hold onto the Business-Critical Information. Where a Customer has not done any business with them in 13 months or more, they are marked as “inactive” and a report is sent to the Marketing Dept to be contacted and offered deals etc. The Dealership also offers servicing of cars. Someone who is not a customer may simply drop a car in for servicing and never buy a car. The Dealership handles servicing through a ticketing system, this uses an alphanumeric numbering system e.g. SRV001. When a customer drops a car in for a either a service or repair they will receive a ticket for that car, there is one ticket per car even if left in by the same customer. Overtime a customer may of course get their car serviced or repaired many times. All this information is held in the Ticketing System, and so a customer/car servicing and repair history can be Page 3 of 9 built up overtime. To keep track of a cars service history, the Dealership records all history against the car’s serial number, this is stored as an alphanumeric with a max size of 12 characters, e.g. SER101021. Each Service Ticket is assigned to a Mechanic. Daily each Mechanic may work on many service tickets. Overtime there are a lot of different tickets per Mechanics and again this history is built up on the Ticketing System. Mechanics are uniquely identified by their MechanicID which is their PPS Number is usually.

## Tools

```
MS SQL Server
```

## ERM (Entity relationship model)
![Entity–relationship model](/conteroDaniel_CA_ERM.png?raw=true)