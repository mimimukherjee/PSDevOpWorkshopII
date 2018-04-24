
#configure
export PATH=/u01/oci/cli/bin:$PATH

echo "[DEFAULT]" > ~/.oci/config
echo "user=$TF_VAR_user_ocid" >> ~/.oci/config
echo "tenancy=$TF_VAR_tenancy_ocid" >> ~/.oci/config
echo "region=$TF_VAR_region" >> ~/.oci/config
echo "fingerprint=$TF_VAR_fingerprint" >> ~/.oci/config
echo "key_file=$TF_VAR_private_key_path" >> ~/.oci/config


#bulk delete obj
#oci os object bulk-delete -ns gse00014442 --force -bn stackdb
#oci os bucket delete -ns gse00014442 --force -bn db
oci os object bulk-delete --force -ns "$TF_VAR_tenancy" -bn $1

