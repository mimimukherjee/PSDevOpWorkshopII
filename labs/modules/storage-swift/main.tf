data "oci_objectstorage_namespace" "t" {
}

resource "oci_objectstorage_bucket" "bucket" {
  compartment_id = "${var.compartment_id}"
  name = "${var.env_prefix}${var.bucket_names[count.index]}"
  namespace = "${data.oci_objectstorage_namespace.t.namespace}"
  count = "${length(var.bucket_names)}"

  provisioner "local-exec" {
    when = "destroy"
    command = "${path.module}/scripts/delete_objs_by_bucket.sh ${var.env_prefix}${var.bucket_names[count.index]}"
  }

}

/*
resource "oci_identity_swift_password" "swift" {
	description = "${var.swift_description}"
	user_id = "${var.user_id}"
}
*/
