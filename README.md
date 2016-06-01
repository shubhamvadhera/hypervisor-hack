# Instrumenting the KVM hypervisor
---

##Assignment requirements
###Prerequisites
* You will need a machine capable of running the Linux KVM hypervisor.

###The Assignment
Your assignment is to add counters to each exit type, to log the number of exits taken for each type. The counters are system-wide, across all VMs. You also will need to add a facility to instruct the hypervisor to dump the counter state to the system message log (dmesg).

At a high level, you will need to perform the following:
* Configure a Linux KVM host machine
* Download the Linux kernel source code
* Modify KVM in the Linux kernel source code to add counters to each exit type
* Add a facility to KVM to print the content of the counters to the system log when requested
* Recompile the new Linux kernel and install

Next, create one (or several) VMs in KVM, and utilize the print feature you implemented to show the number and type of each exit being performed.

---

###Solution
####Processor and Configuration of machine:
Intel Core i5-5200U CPU @ 2.20 Ghz
x64-based processor
Windows 10 64-bit Operating System

I have done this assignment in VMWare installed on the above machine.
VMWare Workstation Pro 12.1.1
* Virtualize Intel VT-x/EPT
* Virtualize CPU performance counters
Host OS - Ubuntu 14.04 LTS

####Pre Requirements:
Before starting the assignment, enable VTx mode on the system.
To check VTx mode, open Task Manager
* Click on Performance Tab, check Virtualization feature in the CPU properties.
If the Virtualization is disabled, follow standard instructions to enable Virtualization from BIOS Setup for
your system model.

####Virtual Machine system requirements:
Minimum space required: 50GB (I used 80 GB - recommended)
RAM: Minimum 4GB (I used 8 GB - recommended)
Processor cores: minimum 4

####Instructions to build and install new kernel:
1. Install Ubuntu 14.04 LTS in a new VM with the given hardware requirements.
2. Once Host OS (Ubuntu) is installed, open a terminal and type following commands to ensure
that virtualization is supported:
 * sudo apt-get update
 * sudo apt-get install cpu-checker
 * sudo kvm-ok
   * INFO: /dev/kvm exists
    * KVM acceleration can be used
3. Run following command to download Linux kernel 4.5.2
 * wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.5.2.tar.xz
4. Extract the files to directory linux-4.5.2
5. Install required packages
 * sudo apt-get install git fakeroot build-essential ncurses-dev xz-utils libssl-dev bc
 * sudo apt-get install kernel-package
6. Copy the Host OS config file to the linux-4.5.2 directory:
 * cd linux-4.5.2
 * sudo cp /boot/config-$(uname -r) .config
7. Make the required changes in the downloaded kernel:
 * Only file vmx.c in directory linux-4.5.2/arch/x86/kvm needs to be replaced with my
vmx.c file
8. Compile the linux kernel:
 * cd linux-4.5.2
 * make menuconfig
  * This opens the GUI of Kernel Configuration
