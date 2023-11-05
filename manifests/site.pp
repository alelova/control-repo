node puppet.local {
  include role::master
}
node elk.local {
  include role::elk
}
node lab-rh9-003 {
  include role::default
  include role::rhel9
}
node default {
  include role::default
}
