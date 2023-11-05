node puppet.local {
  include role::master
}
node elk.local {
  include role::elk
}
node /^lab-rh9/ {
  include role::rhel9
}
node default {
  include role::default
}
