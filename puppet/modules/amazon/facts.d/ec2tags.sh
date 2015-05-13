# Output all of this instance's EC2 tags as puppet facter facts, prefixed with "ec2_tag". 

INSTANCE_ID="`wget -qO- http://169.254.169.254/latest/meta-data/instance-id`"
REGION="`wget -qO- http://169.254.169.254/latest/meta-data/placement/availability-zone | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`"

aws ec2 describe-tags --filters "Name=resource-id,Values=$INSTANCE_ID" --region $REGION --output=text | awk {'print "ec2_tag_" $2 "=" $5'}
