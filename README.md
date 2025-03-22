# Approval App

This is an example of Flutter mobile app built with Firebase to approve documents in the internal organization. Approval of documents might consists of several levels, but documents can only be approved by authorities with a higher position. 

> [!Note]
> For example, if an IT staff request an approval of purchase of computers through the _IT Recommendation Form_ document, then the approval process will be manager -> COO
> 
> However, if the IT manager is the one who requests, then the approval process will be headed to COO directly.

## List of documents and approval flows
Below is a list of documents and approval flows that are currently supported in the app
| Document Type          | Division        | First      | Second  | Details                                                                             |
| ---------------------- | --------------- | ---------- | ------- | ----------------------------------------------------------------------------------- | 
| IT Recommendation Form | IT              | IT Manager | COO     | A document to request for the purchase of technologies used in the organization     |
| Payment Request        | IT & Purchasing | COO        | CFO     | A document to request for reimburse of any purchase made behalf of the organization |

## Status
The status of approval is divided into 3, which are:
1. **Pending**: document is currently being **reviewed** (not all upper positions have approved yet)
2. **_Diterima_**: document is **approved** by all upper positions
3. **_Ditolak_**: document is **rejected** by one of the upper positions, once rejected the process stops and employers have to make a new request.

## To run the app
1. Open the Flutter project and run it by using the command below
   ```
   flutter pub get
   flutter run
   ```
2. The app will direct to the login screen. Because users are retrieved from database and NOT from account creation, **use the following credentials**.
   | Role       | Name      | Email                     | Password      |
   | --------   | --------- | ------------------------- | ------------- |
   | IT Staff   | Test User | test@gmail.com            | testing       |
   | IT Manager | John Doe  | manager.it@impgroup.co.id | managerITimp  |
  <!-- | COO        | Sun Hie   | ccs@impgroup.co.id        | sunhie123     | -->
3. You can logout and switch to other accounts. Happy experimenting!

<!--
## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.  -->
