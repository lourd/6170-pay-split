## FriendSplit - 6.170 Project 3 pt 1


### Purpose and Goal

Our application allows friends or acquaintances to easily settle shared expenses for events. Often, a group of friends participates in an event where for convenience, the purchases for the event are handled by a few of the people, but should ultimately be shared evenly. For example, organizing a birthday party for a friend or buying a gift for a professor. It is a hassle for everybody in the group to keep track of who paid for what and who owes what to whom. 

Our application provides an easier online alternative to handle record keeping for groups and leverages online payment methods such as Venmo to settle debts. For each event, users no longer have to worry about paying individuals, but instead merely pays to the group. Behind the scenes, the application automatically distributes this money to ensure everyone is paid. 


### Functionality

The user creates an event in the application and adds all persons financially involved in the event. Each of the added persons has an account in the application. Any of the added persons can record a purchase for the event. A purchase is something that should be shared by everyone. The application automatically computes how much each person owes or is owed in total for the event. Any of the event persons are then able to settle up by paying the amount they owe directly to the event. The application computes the needed individual transactions to correctly settle up and makes those transfers accordingly, through Venmo or PayPal.

### Features

* Handle Events: Create events with multiple persons involved. Record purchases and payments for any event in which you are participating.
* No hassle payments: Pay directly to events without worrying about who exactly has to be paid. The application will compute that and transfer the money directly from your account.


### Security Concerns
	
A user should only be able to see and have access to events in which he/she is involved. Only the creator of an event should be able to remove that event (if it didn’t happen but was added accidentally) or edit the event (add or remove people from the event). Only users in the event should be able to add purchases or payments to the event. Only the creator of a purchase should be able to edit/remove that purchase.

### Concepts
-----

#### Debt
To use our application, a user understands it is ok for a person they know to participate in an event without paying their share of the cost upfront. There is a level of trust that exists that allows a user to believe their friends will pay later.

#### Money Transfer
A user understands that money can be transferred to another person over the Internet without physically exchanging cash. Moreover, the user trusts the Institutions that move the money from one account to another. 

#### Event
An event is a gathering of friends or acquaintances in which people split the costs of the items involved in the event. For example, an event could be a surprise birthday party, in which the items would be the supplies involved; or it could be a group of people who split the cost of a gift for their professor. In any case, a user knows one may choose to purchase, or buy an item for the event upfront, or wait until the event is over to make a payment, or reimbursement to pay their share to the event fund. What is key is that a user is settling their debt with the event, not individual people. 


### Primary Authorship
-----
* Wireframes - Deborah, Louis, and Cosmin
* Diagrams - Louis
* Purpose and Goals, Security Concerns - Comsin
* Concepts, Functionality, Features - Deborah