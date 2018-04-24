set -x

oci_tf_dir=/app/oci_provider
labs_dir=/app/labs
ssh_dir=/app/sshkey


mkdir -p ~/.ssh
cp $ssh_dir/authorized_keys ~/.ssh/
cp $ssh_dir/testdrive_unix.prv ~/.ssh/id_rsa
cp $ssh_dir/testdrive-public.pub ~/.ssh/id_rsa.pub
chmod 600 ~/.ssh/*

mkdir -p ~/.terraform.d/plugins/
cp $oci_tf_dir/linux_amd64/* ~/.terraform.d/plugins/

cp -r /app/.oci ~
chmod 600 ~/.oci/*

cp -r $labs_dir/* ~

echo "export JAVA_HOME=/app/jdk" >>~/.bash_profile
echo "export PATH=$JAVA_HOME/bin:$PATH" >>~/.bash_profile
