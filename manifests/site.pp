node puppet.local {
  include role::master
}
node elk.local {
  include role::elk
}
node lab-rh9-003.eu-central.compute.internal {
  include role::rhel9
}
node default {
  include role::default
}
