node default {
# The actual role we become has been configured as an EC2 tag.

  include "role::${::ec2_tag_role}"
}
