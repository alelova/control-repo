node puppet.local {
  include role::master
}
node elk.local {
  include role::elk
}
node lab-rh9-003 {
  include role::default
}
node default {
  include role::default
}
