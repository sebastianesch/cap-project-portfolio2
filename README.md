# Getting Started

This repository contains a simple sample application built using SAP Cloud Application Programming Model (CAP) and SAP Fiori Elements to be deployed in the Cloud Foundry environment of SAP BTP.

## Prepare your SAP BTP Trial Account

After you have created your Trial Account for SAP BTP, you have to add a Subscription for SAP HANA Tools to your subaccount and create a SAP HANA Cloud database instance and map it to your Cloud Foundry space, where you will deploy your CAP application. Additionally you have to create a Subscription for SAP Cloud Identity Services to handle user authentication and SAP Build Work Zone to create a central entry point for the users of your apps.

### SAP Cloud Identity Services

In order to activate the SAP Work Zone subscription, you have to setup a trust relationship between your subaccount and a SAP Cloud Identity Service tenant.

1. Go to `Services > Service Marketplace` in the BTP Cockpit.
1. Select `SAP Cloud Identity Services` and create a new Subscription.
1. Select plan `default` in the Subscriptions section.
1. Click on the Go to Subscription button in the confirmation dialog and wait for the subscription to complete.
1. Wait for the activation email for your tenant. It will arrive from `ias@notifications.sap.com` with the Subject `Activate Your Account for Identity Authentication Service`
1. Click on the link to activate your user account in the SAP Cloud Identity Services tenant.

### Establish Trust between your Subaccount and SAP Cloud Identity Services via SAP BTP CLI

At the moment, the BTP Cockpit does not show the `Security > Trust Configuration` menu option. You can establish the trust configuration via the SAP BTP CLI as a workaround.

1. Download the SAP BTP CLI for Linux (x64) from [SAP Development Tools](https://tools.hana.ondemand.com/#cloud) - Cloud section (first section on the page).
1. Upload the archive to SAP Business Application Studio.
1. Create a `bin` folder in your user folder: `mkdir ~/bin`
1. Move the archive to the `bin` folder: `mv btp-cli-linux-amd64-2.83.0.tar.gz ~/bin`
1. Change into the bin folder `cd ~/bin`
1. Extract the archive: `tar xvzf btp-cli-linux-amd64-2.83.0.tar.gz`
1. Move the executable to the `bin` folder: `mv linux-amd64/btp .`

Now you are ready to use the BTP CLI. And you can establish the trust relationship between your subaccount and your Cloud Identity Service tenant.

1. Login to the BTP: `~/bin/btp login --sso`
1. Confirm the BTP CLI API (https://cli.btp.cloud.sap) by pressing enter
1. Click on the link for SSO and confirm in the new browser window
1. Choose your global account (<indentifier>trial)
1. Execute `~/bin/btp target` and pick your subaccount (probably option `1`)
1. Execute `~/bin/btp list security/available-idp` to show the list of available SAP Cloud Identity Service tenants
1. Copy the first column showing the tenant URL from the result
1. Execute `~/bin/btp create security/trust --idp <your CIS tenant>.trial-accounts.ondemand.com`
1. Go to the admin console of your SAP Cloud Identity Services tenant and navigate to `Applications & Resources > Applications>
1. You should see one Application in the "Bundled Applications" list that represents your Subaccount
1. To avoid confusion during login for the applications in the subaccount, we deactivate the Default identity provider for user logon: `~/bin/btp update security/trust sap.default --available-for-user-logon false`

Now you can create the subscription for SAP Build Work Zone. But before you do that, create your SAP HANA Cloud database first.

### SAP HANA Tools

1. Go to `Services > Service Marketplace` in the BTP Cockpit.
1. Select `SAP HANA Cloud` and create a new Subscription.
1. Select the plan `tools` in the Subscriptions section.
1. Click on the Go to Subscription button in the confirmation dialog and wait for the subscription to complete.
1. Assign your user to the SAP HANA Cloud Administrator and SAP HANA Cloud Security Administrator role collections by navigating to `Security > Role Collections` in the BTP Cockpit.
1. Click on the Role Collection `SAP HANA Cloud Administrator`.
1. Click on Edit in the upper right corner.
1. In the User Section enter the email address of your user into the ID field and select `Custom IAS tenant` as Identity Provider.
1. Save the role collection.
1. Click on the Role Collection `SAP HANA Cloud Security Administrator`.
1. Click on Edit in the upper right corner.
1. In the User Section enter the email address of your user into the ID field and select `Custom IAS tenant` as Identity Provider.
1. Save the role collection.
1. Go to `Services > Instances & Subscriptions`, navigate to `SAP HANA Cloud`.
1. The SAP HANA Cloud Central should open.

### SAP HANA Cloud Database Instance

1. Click on Create Instance in SAP HANA Cloud Central.
1. Choose `SAP HANA Cloud, SAP HANA Database` and `Other Environment` as the Runtime Environment and go the the next step.
1. Choose an Instance Name, e.g. `hana` and create a user for the DBADMIN user and go to the next step.
1. In a Trial Account you can' change the size of the HANA Cloud instance, so go to the next step.
1. You cant configure availablility zones or replicas in a Trial Account, so go to the next step.
1. In the Connections section, choose `Allow all IP addresses` and in the Instance Mapping section add a mapping for your Cloud Foundry space, then go to the next step.
1. We don't need a Datalake, so go to the next step.
1. Review and create your SAP HANA Cloud database instance.

Creating the database instance takes some time.

### SAP Build Work Zone

1. Go to `Services > Service Marketplace` in the BTP Cockpit.
1. Select `SAP Build Work Zone, standard edition` and create a new Subscription.
1. Select plan `standard` in the Subscriptions section.
1. Click on the Go to Subscription button in the confirmation dialog and wait for the subscription to complete.
1. Assign your user to the Launchpad_Admin role collection by navigating to `Security > Role Collections` in the BTP Cockpit.
1. Click on the Role Collection `Launchpad_Admin`.
1. Click on Edit in the upper right corner.
1. In the User Section enter the email address of your user into the ID field and select `Custom IAS tenant` as Identity Provider.
1. Save the role collection.
1. Go to `Services > Instances & Subscriptions`, navigate to `SAP Build Work Zone`.
1. The SAP Work Zone Site Manager should open.

### SAP Business Application Studio

Because we established trust with SAP Cloud Identity Services and changed the Default Identity Provider to not be available for User logon, you have to add your user from the Custom IAS tenant to the SAP Business Application Studio (BAS) Role Collection.

1. Navigate to `Security > Role Collections` in BTP Cockpit.
1. Click on the Role Collection `Business_Application_Studio_Developer`.
1. Click on Edit in the upper right corner.
1. In the User Section enter the email address of your user into the ID field and select `Custom IAS tenant` as Identity Provider.
1. Save the role collection.
1. Naviate to `Services > Instances & Subscriptions` in BTP Cockpit.
1. Click on `SAP Business Application Studio` link to open BAS.
1. In BAS click on `Create Dev Space`.
