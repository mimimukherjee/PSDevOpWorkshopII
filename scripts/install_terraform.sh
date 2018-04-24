
script_dir=/app/scripts
software_dir=/app/software
tf_dir=/app/terraform
oci_tf_dir=/app/oci_provider
oci_cli_dir=/app/oci_cli
labs_dir=/app/labs

mkdir -p $software_dir
mkdir -p $tf_dir
mkdir -p $oci_tf_dir
mkdir -p $oci_cli_dir


cd $software_dir

#Get Terraform
tf_vers="0.11.7"
tf_zip="terraform_${tf_vers}_linux_amd64.zip"
wget "https://releases.hashicorp.com/terraform/$tf_vers/$tf_zip"
unzip $tf_zip -d $tf_dir
ln -s $tf_dir/terraform /usr/bin/terraform

#Get OCI Plugin for Terraform
oci_tf_vers=v2.1.5
wget "https://github.com/oracle/terraform-provider-oci/releases/download/$oci_tf_vers/linux_amd64.tar.gz"
cd $oci_tf_dir
tar -xvzf $software_dir/linux_amd64.tar.gz
#Add OCI to Terraform Plugins

#install OCI cli
curl -L "https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh" | bash <<EOF
Y
$oci_cli_dir/lib/oracle-cli
$oci_cli_dir/bin
Y
EOF
ln -s $oci_cli_dir/bin/oci /usr/bin/oci


groupadd devopgrp
$script_dir/create_users.sh
