# Lab Topology

The lab environment includes a Catalyst Center and a Fabric Site.
You will use the Cisco Secure Client on your laptop to establish a VPN session with the dCloud VPN gateway for your assigned POD.

Once the VPN session is established use the RDP client on your laptop to RDP to the Windows Jump host and execute the steps suggested in the lab guides.


![Lab Topology](images/lab-access/Lab_Topology_20251222_1604.jpg)

# Lab Access

## Prerequisites

- dCloud eXpo session access
- VPN client installed on your workstation
- RDP (Remote Desktop Protocol) client

## Access Instructions

### Step 1: Reserve a POD and get VPN access Credentials

Procedure:
- Follow the eXpo link:  <link To Be Added>
- Select a **Session** and click **Explore**
- Enter your **email address**
- Accept **terms and conditions**
- Click **continue**
- Select **Details** tab 
- Select **Cisco Secure Client** tab
- Reveal **Cisco Secure Client Credentials**

![dCloud eXpo Login](images/lab-access/eXpo_login_short_20251217_1018.gif)

### Step 2: Connect to VPN

Open Cisco Secure Client and use the Cisco Secure Client Credentials from the previous step to establish a VPN connection to your assigned session.

### Step 3: Connect to Windows Lab VM

Once connected to the VPN, open an RDP (Remote Desktop Protocol) session to the Windows VM:

- **IP Address**: 198.18.133.20
- **Username**: admin
- **Password**: C1sco12345

### Step 4: Open Ubuntu terminal from within WSL (Windows Subsystem for Linux).

Search for the Ubuntu app:

![Launch the Ubuntu WSL machine](images/lab-access/Launch%20the%20Ubuntu%20WSL%20machine.png)

Click on **Open** to Launch the Ubuntu WSL machine

### Step 5: Clone the DEVWKS-1709 repository

After opening the Ubuntu terminal, clone the GitHub repository with the lab repos:

```bash
git clone https://github.com/fsalvemi/DEVWKS-1709.git
```

### Step 6: Open Visual Studio Code

Change directory to the cloned folder 

```bash
cd DEVWKS-1709
```
and launch Visual Studio Code

```bash
code .
```