set -x

script_dir=/app/scripts
software_dir=/app/software
tf_dir=/app/terraform
oci_tf_dir=/app/oci_provider
oci_cli_dir=/app/oci_cli
labs_dir=/app/labs


#groupadd devopgrp
for i in 1 2 3 4 5
do
  username="devop0$i"
  adduser $username -g devopgrp
  su - $username -c $script_dir/config_user.sh
done
