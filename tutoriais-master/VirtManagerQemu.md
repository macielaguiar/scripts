##Você pode converter o disco existente em um novo disco (que usa preallocation=off) com o seguinte comando:

qemu-img convert -f qcow2 -O qcow2 -o preallocation=off vol.qcow2 newdisk.qcow2


## Converter VDI=virtualbox para QCOW2=virt-manager

qemu-img convert  -f vdi -O qcow2 /home/me/VMs/widows.vdi /home/me/KVM/windows.qcow2


# Converter QCOW2=virt-manager para VDI=virtualbox

qemu-img convert -f qcow2 DebianKDE.qcow2 -O vdi DebianKDE.vdi -p 


##Criar volume/disco pre-alocado Virt-manager

qemu-img create -f qcow2 -o preallocation=off /home/me/KVM/arch.qcow2 50G


To convert VDI image to QCOW2 format:
$ qemu-img convert -O qcow2 input.vdi output.qcow2

To convert VMDK image to QCOW2 format:
$ qemu-img convert -O qcow2 input.vmdk output.qcow2



