# Rather ugly hack to ensure that meta-mender-core's files directory
# is also removed from consideration, since linux-yocto.bbclass adds
# all directories that contain config fragments into its file-cksums
# list, which needlessly (for us) changes the task hash.
python() {
    extrapaths = d.getVar('FILESEXTRAPATHS').split(':')
    newpaths = ':'.join([path for path in extrapaths if not path.endswith('meta-mender-core/recipes-kernel/linux/files')])
    d.setVar('FILESEXTRAPATHS', newpaths)
}

# Remove the enable_efi_stub.cfg file from SRC_URI. This file comes from
# meta-mender-core but is not needed for the Jetson build, and its absence
# was causing a checksum error.
SRC_URI:remove = "file://enable_efi_stub.cfg"
