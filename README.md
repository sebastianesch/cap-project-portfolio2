# Getting Started

This repository contains a simple sample application built using [SAP Cloud Application Programming Model](https://cap.cloud.sap/docs/) (CAP) and [SAP Fiori Elements](https://ui5.sap.com/#/topic/03265b0408e2432c9571d6b3feb6b1fd) to be deployed in the Cloud Foundry environment of SAP BTP.

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

We use the default setup for SAP Business Application Studio in this example to work with the BTP CLI. You can also install the BTP CLI on your local computer (choose the correct download for your platform).

1. Click on `SAP Business Application Studio` link to open BAS.
1. In BAS click on `Create Dev Space`.
1. Choose `Full Stack Cloud Application`.
1. Create your Dev Space.
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

> [!WARNING]
> After completing those steps, don't continue to use this Dev Space. When you close your browser and login to BTP / BAS the next time, your user will be different, and you will not have access to this Dev Space again.
> Make sure everything you need from this Dev Space is stored in Git or exported before logging off.

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
1. Choose `Full Stack Cloud Application`.
1. Create your Dev Space.

### Clone the Repository in BAS

1. In your BAS Dev Space choose from the Welcome Page `Clone from Git` and use the following URL to clone this repository: `https://github.com/sebastianesch/cap-project-portfolio2.git`
1. Alterantively you can open a Terminal in BAS and use `git clone https://github.com/sebastianesch/cap-project-portfolio2.git`
1. After you have cloned the repository, open the terminal in BAS and execute `npm install` in the project directory.

### Deploy to BTP Cloud Foundry

1. To build the Multi-Target-Application (MTA) archive you can either right click on the file `mta.yaml` of the project and select `Build MTA project` or run the command `mbt build` in terminal.
1. Before we can deploy the application, we have to login to Cloud Foundry. You can do this either via the BAS Command Palette and the `Login to Cloud Foundry` option or via the terminal with the command `cf login -a <CF API> --sso`
    1. In the BAS wizard click on the `Open a new browser page to generate your SSO passcode` link, complete the login, and copy the passcode. Then return to BAS, paste the passcode and select your Cloud Foundry organisation and space.
    1. In the terminal enter `cf login -a https://api.cf.us10-001.hana.ondemand.com --sso` and press enter, click on the link to open a new browser tab, complete the login, and copy the passcode. Then return to BAS, paste the passcode and select your Cloud Foundry organisation an space. You can find the CF API URL for your subaccount in the Subaccount Overview in the BTP Cockpit.
1. After the build process is completed you can either right click on the file `mta_archives/cap-project-portfolio_1.0.0.mtar` and select `Deploy MTA archive` or run the command `cf deploy mta_archives/cap-project-portfolio_1.0.0.mtar`.
1. If there are any issues during deployment, CF CLI provides you with the command to download the deployment logs. (`cf dmol -i <deployment id>`).

### Check your Deployment

1. After a successful deployment you can navigate in BTP Cockpit to your Cloud Foundry space: `Subaccount > Cloud Foundry > Spaces > dev`.
1. You should see two applications, one running, one stopped. This is expected.
1. `cap-project-portfolio-db-deployer` is used during deployment to update the database content and is stopped after the deployment is completed.
1. `cap-project-portfolio-srv` is the CAP Node.js application that serves the requests for your application.
1. When you navigate to the HTML5 Applications (`Subaccount > HTML5 Applications`) in BTP Cockpit, you should see the Fiori Apps for your application.

### Setup the SAP Build Work Zone Launchapd

#### Create a new Site

1. Open the SAP Build Work Zone Site Manager (`Services > Instances & Subscriptions > SAP Build Work Zone, standard edition`).
1. Create a new site, e.g. `launchpad`, you can leave the settings as they are and return to the Site Manager.
1. Click on the three dots for your Site and click `Manage Site Alias` and set it to `launchpad`.

#### Update your Content Provider

Navigate to the `Channel Manager` in the left menu. For the `HTML5 Apps` Channel, click the Refresh Action in the Actions
section on the right of the table. Wait for the Status to change to `Updated`.

_**Attention:** Everytime you change your HTML5 Apps, you have to perform a Refresh of the Content Channel, otherwise the
old version of your app will be displayed._

#### Add Content to Your Content

Navigate to the `Content Manager` in the left menu. Click on the `Content Explorer` button and then click on the `HTML5 Apps`
Content Channel. You should see two apps in the list: Customers and Projects. Select both apps and click on `Add`.

#### Create a Group for your Apps

Switch back to the "Content Manager" via the breadcrumb navigation. You should now see the Role `Everyone` and the two apps you added in the previous step. Note that they have `HTML5 Apps` as Channel, the Role has `Local` as Channel.

Click on `Create` and select `Group` to create new tile group for the Launchpad. Name the Group `Project Portfolio`
and assign both apps to your group. Save your group.

#### Create a Role for your Site

In the `Content Manager`, click on `Create` and select `Role` to create a new Role for your Launchpad.

-   **Title:** Project Portfolio User
-   **ID:** Project_Portfolio_User
-   **Description:** User for the Project Portfolio App

Assign both apps to the role and click on save to save your role.

#### Add to the Role to your Site

Navigate to the `Site Directory` and click on the cogwheel icon to open the `Site Settings`. Click on `Role Assignemnt` in the menu on the left. Click on `Edit` in the upper right corner and add the role we created previously to the Site and save.

If you open your Site by clicking on the share icon on your Site in the Site Directory, you will see an empty Launchpad.
Your user is not yet assigned to the Role we just created. This will happen in the next step.

### Update Role Collection and assign your User

Go to the BTP Cockpit and navigate to the `Role Collections` of your subaccount. You should see a Role Collection named
`Project_Portfolio_User`, just like the role we created in the SAP Build Work Zone. If you don't see the Role Collection (e.g.
because the list was open in the Cockpit while you configured the Launchapd), refresh the page.

Click on the Role Collection `Project_Portfolio_User`. On the right side, the details for the Role Collection become
visible. Click on `Edit` to change the Role Collection.

You need to add the roles defined by the CAP Application backend and you need to assign your user to the Role Collection.

### Add required role

In the first section `Roles` click on the value help icon for the `Role Name` field. In the dialog that appears, set
the filter for `Application Identifier` to `cap-roject-portfolio-\<your app identifier\>`. Select all roles of the Project Portfolio app and click `Add` at the bottom of the dialog.

### Add your user

In the section `Users` you can start typing your e-mail address into the `ID` field. Select `Custom IAS tenant` as Identity Provider.

### Confirm your Configuration

After you have completed the configuration of your Launchpad and the Role Collection, you should be able to see the
results in your Launchpad. But at the moment you will only see an empty Launchpad. You have to either open the URL
of your Launchpad in an incognito window of your browser, a different browser or you have to logoff from your SAP Cloud Identity Service tenant and login again.

Copy the link to your Launchpad and open it in an incognito window of your browser. You should now see the Lauchpad
with two tiles for the Customers and Projects app.

## Helpful Links

- [CAP Samples](https://github.com/SAP-samples/cloud-cap-samples)
- [SAP Fiori elements for OData V4 Feature Showcase](https://github.com/SAP-samples/fiori-elements-feature-showcase)

## SAP Learning Journeys

- [Discovering SAP Business Technology Platform](https://learning.sap.com/learning-journeys/discover-sap-business-technology-platform)
- [Getting started with SAP Cloud Application Programming Model](https://learning.sap.com/learning-journeys/getting-started-with-sap-cloud-application-programming-model)
- [Developing an SAP Fiori Elements App Based on a CAP OData V4 Service](https://learning.sap.com/learning-journeys/developing-an-sap-fiori-elements-app-based-on-a-cap-odata-v4-service)
- [Implementing and Administering SAP Build Work Zone](https://learning.sap.com/learning-journeys/implement-and-administer-sap-build-work-zone)
- [Administrating SAP Business Technology Platform](https://learning.sap.com/learning-journeys/administrating-sap-business-technology-platform)
- [Discovering SAP for Students](https://learning.sap.com/learning-journeys/discovering-sap-for-students)