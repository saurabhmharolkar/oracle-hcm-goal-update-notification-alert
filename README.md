# Oracle HCM Goal Update Notification Alert

## Overview

This repository contains the SQL queries and documentation for a **BI Publisher (BIP) alert solution developed in Oracle HCM Cloud** to notify employees when their goals are updated.

The solution identifies goal updates performed by managers or HR and sends automated email notifications using BI Publisher bursting functionality.

This implementation demonstrates event-based alerting and automation using Oracle HCM Goal Management.

---

## Technology Stack

* Oracle HCM Cloud
* Oracle BI Publisher (BIP)
* Oracle SQL
* BI Publisher Bursting

---

## Objective

The objective of this solution is to automatically notify employees when:

* Their goals are updated
* Updates are performed by someone other than themselves

This ensures transparency and keeps employees informed about changes made to their goals.

---

## Solution Architecture

The solution consists of two components:

### 1. Data Model Query (Main Report)

The data model query retrieves:

* Employee details
* Goal name
* Last updated by (person and name)
* Last update timestamp
* Employee email address

This forms the core dataset used in the notification.

---

### 2. Bursting Query (Email Delivery)

The bursting query is used to:

* Identify recipients (employees)
* Define email delivery channel
* Configure email subject and template

It sends an email notification to employees whose goals were updated.

---

## Key Logic

### Identify Goal Updates

The solution identifies goal updates using:

* Records updated in the last 24 hours
* Condition:

  Goal updated by someone other than the employee

---

### Filter Conditions

* Only active goals are considered
* Excludes frozen goal versions
* Uses effective date checks for valid records
* Applies Oracle HCM security restrictions

---

### Notification Trigger

When conditions are met:

* Employee receives an email notification
* Notification includes:

  * Goal Name
  * Updated By
  * Update Date

---

## Oracle HCM Tables Used

### Goal Management

* HRG_GOALS

---

### Employee Data

* PER_ALL_PEOPLE_F
* PER_PERSON_NAMES_F
* PER_EMAIL_ADDRESSES

---

### Security

* PER_PERSON_SECURED_LIST_V

---

## Query Highlights

### Goal Update Detection

The query uses:

* LAST_UPDATE_DATE (within last 24 hours)
* LAST_MODIFIED_BY <> PERSON_ID

to detect updates performed by managers or HR.

---

### Email Extraction

Employee email is retrieved using:

* PER_EMAIL_ADDRESSES
* Email Type = 'W1'

---

### Effective Date Handling

Ensures valid records using:

* Effective start and end date filters
* Active employee and email records

---

## Key Features

* Detects goal updates automatically
* Sends real-time email notifications
* Uses BI Publisher bursting for delivery
* Excludes frozen goal versions
* Supports scheduled execution (daily)
* Ensures data security using secured views

---

## Repository Structure

```id="n2l02j"
oracle-hcm-goal-update-notification-alert
│
├── README.md
├── goal_update_alert_dm.sql
└── goal_update_alert_bursting.sql
```

---

## Scheduling

The report can be scheduled:

* Daily (recommended)
* Example: 6 AM scheduled job

---

## Use Cases

* Notify employees of goal changes
* Improve transparency in goal management
* Track updates made by managers or HR
* Support compliance and audit tracking

---

## Learning Outcomes

This solution demonstrates:

* Oracle HCM Goal Management data model
* BI Publisher bursting configuration
* SQL-based change detection
* Event-driven alert design
* Automation in HCM reporting

---

## Author

Saurabh Mharolkar
Oracle HCM Developer

---

## License

This project is licensed under the MIT License.

